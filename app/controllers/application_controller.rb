class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :public_page?
  before_action :check_if_confirmed, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def public_page?
    # Allow multiple public pages
    controller_name == "home" && %w[index about contact].include?(action_name)
  end

  # Redirect after sign-in
  def after_sign_in_path_for(resource)
    resource.admin? ? admin_dashboard_path : root_path
  end

  # Ensure the avatar field is permitted for account updates
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar ])
  end

  def check_if_confirmed
    return if current_user.confirmed?

    sign_out current_user
    redirect_to new_user_session_path, alert: "Please confirm your email address before logging in."
  end
end
