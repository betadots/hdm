class DummyUser
  def initialize
    unless Rails.configuration.hdm.authentication_disabled
      raise "cannot be used unless authentication is disabled"
    end
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
