class EnvironmentsController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    authorize! :index, Environment
    @environments = Environment.all
    @environments.select! { |e| current_user.may_access?(e) }
  end
end
