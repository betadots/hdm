class SamlSessionsController < ApplicationController
  skip_before_action :authentication_required
  skip_forgery_protection only: :create

  def new
    saml_request = OneLogin::RubySaml::Authrequest.new
    redirect_to saml_request.create(saml_settings), allow_other_host: true
  end

  def create
    saml_response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    saml_response.settings = saml_settings

    if saml_response.is_valid?
      user = find_or_create_user(saml_response)
      session[:user_id] = user.id
      if user.admin?
        redirect_to users_path, notice: "Logged in!"
      else
        redirect_to root_url, notice: "Logged in!"
      end
    else
      redirect_to new_session_path, alert: "Could not sign you in via SSO"
    end
  end

  private

  def find_or_create_user(saml_response)
    User.find_or_create_by!(email: saml_response.nameid) do |user|
      user.first_name = "SAML"
      user.last_name = "User"
    end
  end

  def saml_settings
    settings = Saml.new.settings
    settings.assertion_consumer_service_url = saml_session_url
    settings
  end
end
