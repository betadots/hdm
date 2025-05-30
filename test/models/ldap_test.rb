require 'test_helper'

class LdapTest < ActiveSupport::TestCase
  test "#authenticate delegates to Net::LDAP's #bind_as" do
    stubbed_ldap do |ldap, net_ldap|
      filter = "(mail=test@example.com)"
      net_ldap.expect(:bind_as, 42, [], filter:, password: String)
      authentic = ldap.authenticate("test@example.com", "secret")
      assert_equal authentic, 42
      net_ldap.verify
    end
  end

  test "#authenticate allows overwriting the username attribute" do
    Rails.configuration.hdm[:ldap][:username_attribute] = "uid"
    stubbed_ldap do |ldap, net_ldap|
      filter = "(uid=testuser)"
      net_ldap.expect(:bind_as, 42, [], filter:, password: String)
      authentic = ldap.authenticate("testuser", "secret")
      assert_equal authentic, 42
      net_ldap.verify
    end
    Rails.configuration.hdm[:ldap].delete(:username_attribute)
  end

  test "#authenticate uses an extra filter when given" do
    Rails.configuration.hdm[:ldap][:filter] = "(gid=23)"
    stubbed_ldap do |ldap, net_ldap|
      filter = "(&(gid=23)(mail=test@example.com))"
      net_ldap.expect(:bind_as, 42, [], filter:, password: String)
      authentic = ldap.authenticate("test@example.com", "secret")
      assert_equal authentic, 42
      net_ldap.verify
    end
    Rails.configuration.hdm[:ldap].delete(:filter)
  end

  private

  def stubbed_ldap
    ldap = Ldap.new
    net_ldap = Minitest::Mock.new
    ldap.stub(:ldap, net_ldap) do
      yield ldap, net_ldap
    end
  end
end
