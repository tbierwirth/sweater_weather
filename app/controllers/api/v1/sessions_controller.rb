class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      response = {"api_key": user.api_key}
      render json: response, status: :ok
    else
      render json: "Email does not exist or password is incorrect", status: :bad_request
    end
  end
end
