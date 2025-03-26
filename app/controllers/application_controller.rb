class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!  # Force users to log in before accessing any page

  # Redirect after sign-in
  def after_sign_in_path_for(resource)
    root_path  # Redirect to the home page after successful login
  end

  # Ensure the avatar field is permitted for account updates
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar ])
  end
end
