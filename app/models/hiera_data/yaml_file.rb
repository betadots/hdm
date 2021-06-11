class HieraData
  class YamlFile
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def exist?
      File.exist?(path)
    end

    def keys
      return [] unless exist?
      content.keys
    end

    def content
      return nil unless exist?
      @content ||= YAML.load(File.read(path))
    end

    def content_for_key(key, decrypt_with: nil)
      return nil unless content
      return nil unless content.has_key?(key)

      value = content[key]
      value = decrypt_value(value, *decrypt_with) if decrypt_with

      return "true" if value == true
      return "false" if value == false
      return value if [String, Integer, Float].include?(value.class)

      value_string = value.to_yaml
      value_string.gsub!("---\n", '').gsub!(/^$\n/, '')
      value_string
    end

    def write_key(key, value, encrypt_with: nil)
      new_content = (content ? content : {})
      new_content[key] = encrypt_with ? encrypt_value(value, *encrypt_with) : value

      File.open(path, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      end
    end

    def remove_key(key)
      new_content = (content ? content : {})
      new_content.delete(key)

      File.open(path, File::RDWR|File::CREAT, 0644) do |f|
        f.flock(File::LOCK_EX)
        f.rewind
        f.write(new_content.to_yaml)
        f.flush
        f.truncate(f.pos)
      end
    end

    private

    def decrypt_value(value, private_key, public_key)
      Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = private_key
      Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = public_key
      parser = Hiera::Backend::Eyaml::Parser::Parser.new([Hiera::Backend::Eyaml::Parser::EncHieraTokenType.new, Hiera::Backend::Eyaml::Parser::EncBlockTokenType.new])
      tokens = parser.parse(value.chomp)
      tokens.map(&:to_plain_text).join
    end

    def encrypt_value(value, private_key, public_key)
      Hiera::Backend::Eyaml::Options["pkcs7_private_key"] = private_key
      Hiera::Backend::Eyaml::Options["pkcs7_public_key"] = public_key
      encryptor = Hiera::Backend::Eyaml::Encryptor.find
      ciphertext = encryptor.encode(encryptor.encrypt(value))
      token = Hiera::Backend::Eyaml::Parser::EncToken.new(:block, value, encryptor, ciphertext, nil, '  ')
      token.to_encrypted format: :string
    end
  end
end
