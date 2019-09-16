class Api::V1::BackgroundsController < ApplicationController
  def index
    image = Rails.cache.fetch("images/#{location}", expires_in: 3.minutes) do
      BingService.new.get_images(location)
    end
    
    render json: ImagesSerializer.new(image)
  end

  private
  def location
    params[:location]
  end
end
