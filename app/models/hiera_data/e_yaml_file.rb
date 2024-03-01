class HieraData
  class EYamlFile < YamlFile
    ENCRYPTED_PATTERN = /.*ENC\[.*\]/

    def self.encrypted?(value)
      value.is_a?(String) && !!value.match(ENCRYPTED_PATTERN)
    end

    def self.decrypt_value(value, public_key:, private_key:)
      Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = private_key
      Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = public_key
      parser = Hiera::Backend::Eyaml::Parser::Parser.new([Hiera::Backend::Eyaml::Parser::EncHieraTokenType.new, Hiera::Backend::Eyaml::Parser::EncBlockTokenType.new])
      tokens = parser.parse(value)
      tokens.map(&:to_plain_text).join
    end

    def self.encrypt_value(value, public_key:, private_key:)
      Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = private_key
      Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = public_key
      encryptor = Hiera::Backend::Eyaml::Encryptor.find
      ciphertext = encryptor.encode(encryptor.encrypt(value))
      token = Hiera::Backend::Eyaml::Parser::EncToken.new(:block, value, encryptor, ciphertext, nil, '  ')
      token.to_encrypted format: :string
    end

    def content
      @content ||=
        begin
          super
          decrypt_content if @content && decrypt?
          @content
        end
    end

    private

    def decrypt_content
      public_key = @options[:public_key]
      private_key = @options[:private_key]
      @content.transform_values! do |value|
        if self.class.encrypted?(value)
          self.class.decrypt_value(value, public_key:, private_key:)
        else
          value
        end
      end
    end

    def decrypt?
      @options[:decrypt] &&
        @options[:public_key] &&
        @options[:private_key]
    end
  end
end
