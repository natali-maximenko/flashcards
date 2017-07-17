require 'rails_helper'

RSpec.describe PictureUploader, type: :model do
  let(:card) { create(:card) }
  let(:uploader) { PictureUploader.new(card, :picture) }

  before do
    PictureUploader.enable_processing = true
    File.open("#{::Rails.root}/spec/support/fixtures/ciklon.jpg") { |f| uploader.store!(f) }
  end

  after do
    PictureUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be fit within 100 by 100 pixels" do
      expect(uploader.thumb).to be_no_larger_than(100, 100)
    end
  end

  context 'the original version' do
    it "scales down a landscape image to fit within 360 by 360 pixels" do
      expect(uploader).to be_no_larger_than(360, 360)
    end
  end

  it "has the correct format" do
    expect(uploader).to be_format('jpeg')
  end

end
