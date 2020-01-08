class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :url, ImageUploader

  validates :url,     presence: true
end
