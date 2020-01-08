class SetBrand < ApplicationRecord
  belong_to :brand
  belong_to :brand_category
end
