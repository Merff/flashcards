require 'carrierwave/test/matchers'
require 'rails_helper'

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:card) { create(:card) }
  let(:uploader) { AvatarUploader.new(card, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open("#{Rails.root}/spec/w12.jpg") { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  it "avatar has normal size virsion" do
    expect(uploader).to be_no_larger_than(360, 360)
  end
end
