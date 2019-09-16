class BackgroundImage
  attr_reader :id, :name, :url, :height, :width

  def initialize(image)
    @id = image[:imageId]
    @name = image[:name]
    @url = image[:contentUrl]
    @height = image[:height]
    @width = image[:width]
  end
end
