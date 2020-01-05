class Category < ApplicationRecord
  has_ancestry
  has_many :products
  has_many :brand_categories
  has_many :brands, through: :brand_categories
  has_many :size_categories
  has_many :sizes, through: :size_categories
end
