class User < ApplicationRecord
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    sns_credential_record = SnsCredential.where(provider: auth.provider, uid: auth.uid)
    if user.present?
      unless sns_credential_record.present?
        SnsCredential.create(
          user_id: user.id,
          provider: auth.provider,
          uid: auth.uid
        )
      end
    elsif
      user = User.new(
        id: User.all.last.id + 1,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        nickname: auth.info.name,
        last_name: auth.info.last_name,
        first_name: auth.info.first_name,
      )
      SnsCredential.new(
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
      )
    end 
  user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :snscredentials, dependent: :destroy
  has_one :creditcard, dependent: :destroy
  has_one :streetaddress, dependent: :destroy
  accepts_nested_attributes_for :streetaddress

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  @password = Devise.friendly_token.first(8)
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    credential = Credential.where(uid: uid, provider: provider).first
    if credential.present?
      user = User.where(id: credential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        Credential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      else
        user = User.new(
          nickname: auth.info.name,
          email:    auth.info.email,
          password: @password,
          password_confirmation: @password
        )
      end
    end
    return user
  end


         validates :first_name, :last_name, :first_name_kana, :last_name_kana,
         :birth_year, :birth_month, :birth_day, presence: true
  
        #  validates :password, length: {minimum: 7}
  has_one :card, dependent: :destroy

  has_one :streetaddress, dependent: :destroy
  has_one :creditcard, dependent: :destroy
  has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'
  has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
  has_many :credentials, dependent: :destroy
  has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
  has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'
  has_many :likes, dependent: :destroy
  has_many :like_products, through: :likes, source: :product

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }


  validates :nickname, presence: true,uniqueness: true, length: {maximum: 20}
  validates :phone_number,presence: true,uniqueness: true

  validates :first_name, :last_name, :first_name_kana, :last_name_kana,
  :birth_year,:birth_month,:birth_day, presence: true

  validates :password, length: {minimum: 7}

end
