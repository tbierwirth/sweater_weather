class GifSerializer < ActiveModel::Serializer
  attributes :time, :summary, :url
end
