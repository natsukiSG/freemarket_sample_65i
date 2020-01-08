class Image < ApplicationRecord
  belongs_to :product
  validates :url,     presence: true
end
