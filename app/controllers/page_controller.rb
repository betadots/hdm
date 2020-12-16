class PageController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    if Role.none?
      redirect_to page_faulty_setup_path, notice: 'There are no roles in the database.'
    else
      if User.none?
        redirect_to new_user_path, notice: 'Please create an admin user first.'
      end
    end
  end

  def about_us
    add_breadcrumb "About us", :page_about_us_path
  end

  def faulty_setup
    add_breadcrumb "Faulty setup", :page_faulty_setup_path
  end  
end
