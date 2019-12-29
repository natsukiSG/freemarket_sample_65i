class Creditcard < ApplicationRecord
  belongs_to :user, optional: true
end
