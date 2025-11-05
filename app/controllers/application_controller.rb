class ApplicationController < ActionController::Base
  rescue_from Hdm::Error, with: :display_error_page
  rescue_from CanCan::AccessDenied, with: :access_denied

  before_action :authentication_required

  helper_method :current_user, :rbac_enabled?

  private

  def current_user
    @current_user ||=
      if Rails.configuration.hdm.authentication_disabled
        DummyUser.new
      else
        if User.none?
          session[:user_id] = nil
        end

        if session[:user_id]
          Current.user ||= User.find(session[:user_id])
        end
      end
  end

  def authentication_required
    unless current_user
      if admin_user_missing?
        redirect_to initial_setup_path, notice: 'Please create an admin user first.'
      else
        redirect_to login_path
      end
    end
  end

  def load_environments
    @environments = Environment.all
    @environments.select! { |e| current_user.may_access?(e) }
    @environment = Environment.find(params[:environment_id])
    authorize! :show, @environment
  end

  def load_nodes
    @nodes = Node.all
    @nodes.select! { |n| current_user.may_access?(n) }
    @node = Node.find(params[:node_id])
    authorize! :show, @node
  end

  def display_error_page(error)
    @error = error
    render template: "page/error", status: :internal_server_error
  end

  def access_denied
    render file: Rails.public_path.join('403.html'), status: :forbidden, layout: false
  end

  def admin_user_missing?
    User.none? && !Rails.configuration.hdm.authentication_disabled
  end

  def rbac_enabled?
    Group.any?
  end

  def ensure_rbac_disabled
    head :forbidden if rbac_enabled?
  end
end
