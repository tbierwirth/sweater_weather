class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      trip = RoadTrip.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(trip)
    else
      render json: "API key is not valid", status: :unauthorized
    end
  end
end
