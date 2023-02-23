class Saml
  def self.configured?
    Rails.configuration.hdm[:saml].present?
  end

  def initialize
    @hdm_settings = Rails.configuration.hdm[:saml]
    @hdm_settings[:name_identifier_format] ||= "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  end

  def settings
    OneLogin::RubySaml::Settings.new(@hdm_settings)
  end
end
