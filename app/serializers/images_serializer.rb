class ImagesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :url, :height, :width
end
