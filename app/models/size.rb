class Size < ApplicationRecord
  has_many :size_categories
  has_many :categories, through: :size_categories
  has_many :products
  has_many :searchsize_sizes
  has_many :searchsizes, through: :searchsize_sizes
end
