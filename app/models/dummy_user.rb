class DummyUser
  def initialize
    raise "cannot be used unless authentication is disabled" unless Rails.configuration.hdm.authentication_disabled
  end

  def id
    nil
  end

  def username
    "anonymous"
  end

  def admin?
    false
  end

  def user?
    true
  end

  def api?
    true
  end

  def may_access?(_record)
    true
  end
end
