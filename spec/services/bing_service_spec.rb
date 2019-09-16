require 'rails_helper'

RSpec.describe BingService do
  before :each do
    images = File.open('./spec/fixtures/images.json')
    stub_request(:get, "https://api.cognitive.microsoft.com/bing/v7.0/images/search?imageType=photo&license=public&minHeight=768&minWidth=1024&q=denver,co,background").
      to_return(status: 200, body: images)
  end

  describe "instance methods" do
    context "#get_images" do
      it "can return images if given city,state" do
        location = "denver,co"
        service = BingService.new(location)
        images = service.get_images
        expect(images.first.url).to eq("https://static.pexels.com/photos/110924/pexels-photo-110924.jpeg")
      end
    end
  end
end
