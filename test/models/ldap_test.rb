require 'test_helper'

class LdapTest < ActiveSupport::TestCase
  test "#authenticate delegates to Net::LDAP's #bind_as" do
    ldap = Ldap.new
    net_ldap = Minitest::Mock.new
    ldap.stub(:ldap, net_ldap) do
      net_ldap.expect(:bind_as, 42, [], filter: String, password: String)
      authentic = ldap.authenticate("test@example.com", "secret")
      assert_equal authentic, 42
      net_ldap.verify
    end
  end
end
