class Gif
  attr_reader :id, :time, :summary, :url

  def initialize(time, summary, url)
    @time = time
    @summary = summary
    @url = url
  end
end
