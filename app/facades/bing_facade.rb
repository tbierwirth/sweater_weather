class BingFacade
  def initialize(location)
    @location = location
  end

  def get_images
    images.map do |image|
      BackgroundImage.new(image)
    end
  end

  def images
    @_images = BingService.new(@location).get_images
  end
end
