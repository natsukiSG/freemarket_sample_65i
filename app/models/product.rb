class Product < ApplicationRecord
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id',optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id',optional: true
  has_many :images

end
