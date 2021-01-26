class PuppetEnvironmentsController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  # GET /puppet_environments
  def index
    add_breadcrumb "Environments", puppet_environments_path
    @puppet_environments = @puppet_environments.order(:name)
  end

  # GET /puppet_environments/1
  def show
    add_breadcrumb "Environments", puppet_environments_path
    add_breadcrumb @puppet_environment.name, @puppet_environment
  end

  # GET /puppet_environments/new
  def new
    @puppet_environment = PuppetEnvironment.new
  end

  # GET /puppet_environments/1/edit
  def edit
  end

  # POST /puppet_environments
  def create
    @puppet_environment = PuppetEnvironment.new(puppet_environment_params)

    if @puppet_environment.save
      redirect_to @puppet_environment, notice: 'Puppet environment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /puppet_environments/1
  def update
    if @puppet_environment.update(puppet_environment_params)
      redirect_to @puppet_environment, notice: 'Puppet environment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /puppet_environments/1
  def destroy
    @puppet_environment.destroy
    redirect_to puppet_environments_url, notice: 'Puppet environment was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def puppet_environment_params
      params.require(:puppet_environment).permit(:name)
    end
end
