class ToppageController < ApplicationController
  def index
    # @categories = Category.roots
    @popular = []
  end

  def show
  end

# 出品ページ
  def edit
    @toppage = Product.find(params[:id])
    gon.count = @product.images.length
    if @product.buyer_id != nil || @product.seller_id != current_user.id
      redirect_to root_path
    end
    @profit = (@product.price * 0.9).round
    @fee = @product.price - @profit
  end
end