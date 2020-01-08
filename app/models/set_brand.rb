class SetBrand < ApplicationRecord
  belongs_to :brand
  belongs_to :brand_category
end
