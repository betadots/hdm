class DummyUser
  def initialize
    raise "cannot be used unless authentication is disabled" unless Rails.configuration.hdm.authentication_disabled
  end

  def id
    nil
  end

  def email
    "anonymous"
  end

  def admin?
    false
  end

  def user?
    true
  end
end
