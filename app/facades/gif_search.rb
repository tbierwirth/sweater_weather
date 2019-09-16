class GifSearch
  def initialize(forecast)
    @forecast = forecast
  end

  def get_gifs
    service = GifService.new
    @forecast[:data].map do |daily|
      gif = service.get_gif(daily[:summary])
      url = gif.shuffle[0][:url]
      Gif.new(daily[:time], daily[:summary], url)
    end
  end

  def response
    {
      data: {
        images:
          get_gifs.map do |gif|
            GifSerializer.new(gif)
          end
      },
      copyright: "2019"
    }
  end
end
