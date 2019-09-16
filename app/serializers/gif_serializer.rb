class GifSerializer < ActiveModel::Serializer
  attributes :time, :summary, :url
  def copyright
    'copright: "2019"'
  end
end
