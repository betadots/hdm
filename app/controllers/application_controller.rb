class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    if User.none?
      session[:user_id] = nil
    end

    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
end
