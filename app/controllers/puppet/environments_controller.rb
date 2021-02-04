class Puppet::EnvironmentsController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :puppet_environments_path

  def index
    @environments = @environments.order(:name)
  end

  def show
    add_breadcrumb @environment.name, @environment
  end

  def new
    @environment = Puppet::Environment.new
  end

  def edit
    @environment.configurations.build
  end

  def create
    @environment = Puppet::Environment.new(environment_params)

    if @environment.save
      redirect_to [:edit, @environment], notice: 'Environment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @environment.update(environment_params)
      redirect_to [:edit, @environment], notice: 'Environment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @environment.destroy
    redirect_to puppet_environments_url, notice: 'Environment was successfully destroyed.'
  end

  private

  def environment_params
    params.require(:puppet_environment).permit(:name, configurations_attributes: {})
  end
end
