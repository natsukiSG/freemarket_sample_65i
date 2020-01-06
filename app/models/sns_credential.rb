class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true
  validates :uid, :provider, presence: true
end
