class BrandCategory < ApplicationRecord
  has_many :set_brands
  has_many :brands, through: :set_brands
end
