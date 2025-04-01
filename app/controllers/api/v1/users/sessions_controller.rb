class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json # You can remove turbo_stream since we are doing full-page redirects now

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)

      # Redirect after successful login
      redirect_to root_path, notice: "Signed in successfully."
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)

    # Redirect after successful sign out
    redirect_to root_path, notice: "Signed out successfully."
  end
end
