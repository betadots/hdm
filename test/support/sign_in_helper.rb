module SignInHelper
  def sign_in_as(user, password: "password")
    post sessions_path(email: user.email, password:)
    follow_redirect!
  end

  def basic_auth_header(user: nil)
    password = "apiuser23"
    user ||= FactoryBot.create(:user, :api, password:)
    authorization = ActionController::HttpAuthentication::Basic
                    .encode_credentials(user.email, password)
    { 'HTTP_AUTHORIZATION' => authorization }
  end
end
