require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo = photos(:one)
  end

  test "should get index" do
    get photos_url
    assert_response :success
  end

  test "should get new" do
    get new_photo_url
    assert_response :success
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      file = fixture_file_upload("files/example.png", "image/png")
      post photos_url, params: { photo: { image: file, title: "Test Photo" } }
    end

    photo = Photo.last
    assert_redirected_to photo_url(photo)
    assert_equal "Test Photo", photo.title
    assert_equal "example.png", photo.image.metadata["filename"]
  end

  test "should not create photo if file type is not an image" do
    assert_no_difference('Photo.count') do
      file = fixture_file_upload("files/dummy.pdf", "application/pdf")
      post photos_url, params: { photo: { image: file, title: "Test PDF" } }
    end

    assert_select "li", "Image type must be one of: image/jpeg, image/png, image/webp"
  end

  test "should show photo" do
    get photo_url(@photo)
    assert_response :success
    assert_select "img" do
      assert_select "[src=?]", @photo.image_url
    end
  end

  test "should get edit" do
    get edit_photo_url(@photo)
    assert_response :success
  end

  test "should update photo" do
    patch photo_url(@photo), params: { photo: { image_data: @photo.image_data, title: @photo.title } }
    assert_redirected_to photo_url(@photo)
  end

  test "should destroy photo" do
    assert_difference('Photo.count', -1) do
      delete photo_url(@photo)
    end

    assert_redirected_to photos_url
  end
end
