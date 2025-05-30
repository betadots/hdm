class Ldap
  def self.configured?
    Rails.configuration.hdm[:ldap].present?
  end

  def initialize
    hdm_ldap_config = Rails.configuration.hdm[:ldap]
    @host = hdm_ldap_config[:host]
    @port = hdm_ldap_config[:port] || 389
    @bind_dn = hdm_ldap_config[:bind_dn]
    @bind_dn_password = hdm_ldap_config[:bind_dn_password]
    @base_dn = hdm_ldap_config[:base_dn]
    @username_attribute = hdm_ldap_config[:username_attribute] || "mail"
    @filter = hdm_ldap_config[:filter]
    @ssl_mode = hdm_ldap_config[:ssl_mode]
    @ca_file = hdm_ldap_config[:ca_file]
    @ssl_verify = hdm_ldap_config.fetch(:ssl_verify, true)
  end

  def authenticate(username, password)
    return unless username.present? && password.present?

    filter = filter_for(username)
    ldap.bind_as(filter:, password:)
  end

  private

  def filter_for(username)
    base = "(#{@username_attribute}=#{username})"
    if @filter.present?
      "(&#{@filter}#{base})"
    else
      base
    end
  end

  def ldap
    ldap = Net::LDAP.new(
      host: @host,
      port: @port,
      base: @base_dn,
      encryption:
    )
    ldap.authenticate @bind_dn, @bind_dn_password if @bind_dn
    ldap
  end

  def encryption
    ssl_method = case @ssl_mode
                 when "simple"
                   :simple_tls
                 when "starttls"
                   :start_tls
                 else
                   return
                 end
    {
      method: ssl_method,
      tls_options: {
        ca_file: @ca_file,
        verify_mode: @ssl_verify ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE
      }
    }
  end
end
