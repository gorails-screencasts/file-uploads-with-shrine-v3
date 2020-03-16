module TestData
  module_function

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)

    # if you're processing derivatives
    #attacher.set_derivatives(
    #  large:  uploaded_image,
    #  medium: uploaded_image,
    #  small:  uploaded_image,
    #)

    attacher.column_data # or attacher.data in case of postgres jsonb column
  end

  def uploaded_image
    file = File.open("test/fixtures/files/example.png", binmode: true)

    # for performance we skip metadata extraction and assign test metadata
    uploaded_file = Shrine.upload(file, :store, metadata: false)
    uploaded_file.metadata.merge!(
      "size"      => File.size(file.path),
      "mime_type" => "image/png",
      "filename"  => "example.png",
    )

    uploaded_file
  end
end
