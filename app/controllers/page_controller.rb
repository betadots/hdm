class PageController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    if Role.none?
      raise Hdm::Error, "There are no roles in the database. You need to seed the DB before using this application."
    else
      if User.none?
        redirect_to new_user_path, notice: 'Please create an admin user first.'
      end
    end
  end
end
