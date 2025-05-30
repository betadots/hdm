class UsersController < ApplicationController
  skip_before_action :authentication_required, only: [:new, :create]
  before_action :conditional_authentication, only: [:new, :create]

  load_and_authorize_resource
  add_breadcrumb "Home", :root_path

  # GET /users
  def index
    add_breadcrumb "Users", :users_path
    @users = @users.order(:username)
  end

  # GET /users/1
  def show
    add_breadcrumb "Users", :users_path
    add_breadcrumb @user.username, user_path(@user)
  end

  # GET /users/new
  def new
    add_breadcrumb "Users", :users_path
    add_breadcrumb "Sign up", :signup_path
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    add_breadcrumb "Users", :users_path
    add_breadcrumb @user.username, user_path(@user)
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if User.none?
      @user.role = "admin"
    end

    if @user.save
      if User.count == 1
        session[:user_id] = @user.id
        redirect_to root_url, notice: "Welcome to the system! You are logged in with admin privileges."
      else
        redirect_to @user, notice: 'User was successfully created.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    if @user == current_user
      session[:user_id] = nil
      redirect_to root_url, notice: "Your account was successfully destroyed and logged out!"
    else
      redirect_to users_path, notice: 'User was successfully destroyed.'
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def user_params
      # The last admin can't change his/her role to a non admin role.
      #
      if User.admins.count == 1 && current_user == @user
        params.expect(user: [:first_name, :last_name, :username, :password, :password_confirmation])
      else
        if current_user.try(:admin?)
          params.expect(user: [:first_name, :last_name, :username, :password, :password_confirmation, :role])
        else
          params.expect(user: [:first_name, :last_name, :username, :password, :password_confirmation])
        end
      end
    end

    def conditional_authentication
      authentication_required if User.exists?
    end
end
