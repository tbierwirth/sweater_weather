require 'rails_helper'

RSpec.describe BingService do
  before :each do
    images = File.open('./spec/fixtures/images.json')
    stub_request(:get, "https://api.cognitive.microsoft.com/images/search?q=denver,co").
      to_return(status: 200, body: images)
  end

  describe "instance methods" do
    context "#get_images" do
      it "can return images if given city,state" do
        location = "denver,co"
        service = BingService.new
        images = service.get_images(location)[:value]
        expect(images.first[:contentUrl]).to eq("https://media.timeout.com/images/105124787/image.jpg")
      end
    end
  end
end
