require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#authenticate will not authenticate user without password" do
    user = FactoryBot.create(:user, password: nil, password_digest: nil)
    refute user.authenticate("secret")
  end

  test "#authenticate will authenticate user with correct password" do
    user = FactoryBot.create(:user)
    assert user.authenticate("secret")
  end

  test "#authenticate will not authenticate when given wrong password" do
    user = FactoryBot.create(:user)
    refute user.authenticate("password")
  end
end
