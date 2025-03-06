class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      render json: { message: "Password has been reset.", user_token: Current.session.token }
    else
      render json: { error: "Passwords did not match." }
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_password_reset_token!(params[:token])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    render json: { error: "Invalid token" }, status: :unauthorized
  end
end
