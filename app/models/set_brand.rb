class SetBrand < ApplicationRecord
  belongs_to :brand_category
  belongs_to :brand
end
