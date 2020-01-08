class ProductsController < ApplicationController
  before_action :set_product, :set_card
  require "payjp"


  def buy_confirmation
      if @product.buyer == nil && @product.seller != current_user.id
        @streetaddress = StreetAddress.find_by(user_id: current_user.id)
        if Creditcard.present?
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          customer = Payjp::Customer.retrieve(@card.customer_id)
          @default_card_information = customer.cards.retrieve(@card.card_id)
        end
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
