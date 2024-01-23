class PageController < ApplicationController
  skip_before_action :authentication_required

  add_breadcrumb "Home", :root_path

  def index
    if admin_user_missing?
      redirect_to initial_setup_path
    end
  end

  def initial_setup; end
end
