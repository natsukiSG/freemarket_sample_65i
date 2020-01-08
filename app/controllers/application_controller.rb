class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :set_parents
  protect_from_forgery with: :exception
  before_action :set_brands

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :nickname, :email, :password, :password_confirmation, :birthday, :comment, :payment])
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end


  def set_product
    @product = Product.find(params[:id])
  end

  def set_card
    @card = Creditcard.find_by(user_id: current_user.id)
  end

  def set_parents
    @parents = Category.where(ancestry: nil).order("id ASC")
  end

  def set_brands
    brand_ids = Product.group(:brand_id).order('count_brand_id DESC').limit(4).count(:brand_id).keys
    popular_brands = []
    popular_brands = brand_ids.select { |id| id != nil }
    @brands = popular_brands.map { |id| Brand.find(id) }
  end
end
