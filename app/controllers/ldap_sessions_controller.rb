class LdapSessionsController < ApplicationController
  skip_before_action :authentication_required

  add_breadcrumb "Home", :root_path

  def new
    add_breadcrumb "Login (LDAP)", :login_path

    redirect_to root_url, alert: "You have to logout first to login!" if session[:user_id]
  end

  def create
    ldap = Ldap.new
    if (entries = ldap.authenticate(params[:username], params[:password]))
      user = find_or_create_user(entries.first)
      session[:user_id] = user.id
      if user.admin?
        redirect_to users_path, notice: "Logged in!"
      else
        redirect_to root_url, notice: "Logged in!"
      end
    else
      flash.now[:alert] = "Username or password is invalid"
      render "new", status: :unprocessable_entity
    end
  end

  private

  def find_or_create_user(ldap_user)
    User.find_or_create_by!(username: params[:username].downcase) do |user|
      user.first_name = ldap_user.givenname.first || "ldap"
      user.last_name = ldap_user.sn.first || "user"
    end
  end
end
