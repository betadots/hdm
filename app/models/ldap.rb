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
    @ldaps = hdm_ldap_config[:ldaps]
  end

  def authenticate(email, password)
    ldap.bind_as(filter: "(mail=#{email})", password: password) if email.present? && password.present?
  end

  private

  def ldap
    encryption = @ldaps ? { method: :simple_tls } : nil
    ldap = Net::LDAP.new(
      host: @host,
      port: @port,
      base: @base_dn,
      encryption: encryption
    )
    ldap.authenticate @bind_dn, @bind_dn_password if @bind_dn
    ldap
  end
end
