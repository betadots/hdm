class PageController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    if User.none?
      redirect_to new_user_path, notice: 'Please create an admin user first.'
    end
  end

  def about_us
    add_breadcrumb "About us", :root_path
  end
end
