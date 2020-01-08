class ProductsController < ApplicationController
  before_action :set_product, :set_card
  require "payjp"

  def index
    @categories = Category.roots
    @products = @categories.map{|root| Product.where(category_id: root.subtree)}
    @sorted_products = @products.sort {|a,b| b.length <=> a.length }
    @popular = []
    @sorted_products.each.with_index(1) do |products, i|
      if (i <= 4)
        @popular << products
      else
        break
      end
    end
  end
  
  def new
    @product = Product.new
    gon.count = 0
  end

  def create
    @product = Product.new(product_params)
    if (params[:images] != nil)
      if @product.save
        params[:images]['url'].each do |image|
          @product.images.create(url: image, product_id: @product.id)
          end
        redirect_to root_path
      else
        redirect_to new_product_path
      end
    else
      redirect_to new_product_path
    end
  end

  def edit
  end

  def buy_confirmation
    @streetaddress = StreetAddress.find_by(user_id: current_user.id)
      if @card.present?
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)
    else
      redirect_to root_path
    end
  end
  

  def pay 
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @product.price, #支払金額
    :customer => @card.customer_id, #顧客ID
    :currency => 'jpy',
  )
  redirect_to action: 'done'
  end
  
end

