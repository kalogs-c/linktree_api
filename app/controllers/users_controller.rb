class UsersController < ApplicationController
  allow_unauthenticated_access only: :create
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render json: { error: "Too many requests" } }


  def create
    attrs = params.permit(:name, :username, :email_address, :password)
    user = User.new(attrs)

    if user.save
      start_new_session_for user
      render json: { message: "User has been created.", user_token: Current.session.token }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
