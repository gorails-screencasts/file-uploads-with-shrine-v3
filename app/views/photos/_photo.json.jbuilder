json.extract! photo, :id, :title, :image_data, :created_at, :updated_at
json.url photo_url(photo, format: :json)
