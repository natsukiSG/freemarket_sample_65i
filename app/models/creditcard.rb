class Creditcard < ApplicationRecord
  belongs_to :user, optional: true
  validates :card_id, :customer_id, presence: true
end
