class StreetAddress < ApplicationRecord
  belongs_to :user, optional: true
  validates :address_last_name, :address_first_name, :address_first_name_kana, 
            :address_last_name_kana, :post_number, :prefectures, :city, :house_number, presence: true
end
