class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.find_or_create_by!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, user: user }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
    )
  end

end
