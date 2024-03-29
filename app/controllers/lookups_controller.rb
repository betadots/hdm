class LookupsController < ApplicationController
  before_action :load_environments
  before_action :load_nodes
  before_action :load_keys

  def show
    @result = @key.lookup(@node)
  rescue Hdm::Error => e
    @error = e

    render action: "error"
  end

  private

  def load_keys
    @keys = Key.all_for(@node, environment: @environment)
    @keys.select! { |k| current_user.may_access?(k) }
    @key = Key.new(environment: @environment, name: params[:key_id])
    authorize! :show, @key
  end
end
