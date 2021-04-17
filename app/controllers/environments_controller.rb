class EnvironmentsController < ApplicationController
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    @environments = Environment.all
    authorize! :index, Environment
  end
end
