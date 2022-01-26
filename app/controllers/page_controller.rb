class PageController < ApplicationController
  skip_before_action :authentication_required

  add_breadcrumb "Home", :root_path

  def index
    if User.none?
      redirect_to new_user_path, notice: 'Please create an admin user first.'
    end
  end
end
