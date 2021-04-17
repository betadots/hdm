module SignInHelper
  def sign_in_as(user, password: "password")
    post sessions_path(email: user.email, password: password)
  end
end
