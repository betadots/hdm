class SessionsController < ApplicationController
  skip_before_action :authentication_required

  add_breadcrumb "Home", :root_path

  def new
    add_breadcrumb "Login", :login_path

    if session[:user_id]
      redirect_to root_url, alert: "You have to logout first to login!"
    end
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to users_path, notice: "Logged in!"
      else
        redirect_to root_url, notice: "Logged in!"
      end
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
