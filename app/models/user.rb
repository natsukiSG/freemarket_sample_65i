class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        #  validates :nickname, presence: true,uniqueness: true, length: {maximum: 20}
        #  validates :phone_number,presence: true,uniqueness: true

        #  validates :first_name, :last_name, :first_name_kana, :last_name_kana,
        #  :birth_year,:birth_month,:birth_day,:comment, presence: true
  
        #  validates :password, length: {minimum: 7}
end
