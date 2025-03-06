class UsersController < ApplicationController
  def create
    attrs = params.permit(:email_address, :password, :password_confirmation)
    user = User.new(attrs)

    if user.save
      render json: { message: "User has been created." }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
