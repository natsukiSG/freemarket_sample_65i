class Product < ApplicationRecord
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id',optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id',optional: true
  has_many :comments, dependent: :destroy
  belongs_to :category,optional: true

  belongs_to :brand, optional: true
  belongs_to :size, optional: true
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  accepts_nested_attributes_for :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :transaction

  validates :name,                  presence: true, length: { maximum: 40 }
  validates :comment,               presence: true, length: { maximum: 100 }
  validates :price,                 presence: true, length: { maximum: 7 }
  validates :status,                presence: true
  validates :costcharge,            presence: true
  validates :delivery_way,          presence: true
  validates :delivery_area,         presence: true
  validates :delivery_date,         presence: true
  validates :category_id,              presence: true

  enum status: {'新品、未使用':1,'未使用に近い':2,'目立った傷や汚れなし':3,'やや傷や汚れがあり':4,'傷や汚れあり':5,'全体的に状態が悪い':6}

  enum costcharge: {'着払い(購入者負担)':1,'送料込み(出品者負担)':2}
end