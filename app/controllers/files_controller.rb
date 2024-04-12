class FilesController < ApplicationController
  before_action :load_environments
  before_action :load_key

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Environments", :environments_path

  def index
    @files_and_values =
      if can? :show, @key
        @key.search(environment: @environment)
      else
        {}
      end

    add_breadcrumb @environment, environment_nodes_path(@environment)
    add_breadcrumb @key, environment_key_files_path(@environment, @key)
  end

  private

  def load_key
    @key = Key.new(name: params[:key_id].squish)
  end
end
