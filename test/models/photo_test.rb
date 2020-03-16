require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test "extracts metadata" do
    photo = Photo.create(title: "test", image: Rack::Test::UploadedFile.new("test/fixtures/files/example.png", "image/png"))
    assert photo.valid?
    assert_equal "example.png", photo.image.metadata["filename"]
  end

  test "does not accept pdfs" do
    photo = Photo.create(title: "test", image: File.open("test/fixtures/files/dummy.pdf", "rb"))
    assert_not photo.valid?
    assert_equal "type must be one of: image/jpeg, image/png, image/webp", photo.errors[:image].first
  end
end
