class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)

      redirect_to root_path, notice: "Signed in successfully."
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)

    redirect_to root_path, notice: "Signed out successfully."
  end
end
