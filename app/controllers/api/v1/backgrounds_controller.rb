class Api::V1::BackgroundsController < ApplicationController
  def index
    images = Rails.cache.fetch("images/#{location}", expires_in: 3.minutes) do
      BingFacade.new(location).get_images
    end

    render json: ImagesSerializer.new(images)
  end

  private
  def location
    params[:location]
  end
end
