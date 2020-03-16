class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, :image, presence: true
end
