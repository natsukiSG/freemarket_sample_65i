class TopsController < ApplicationController
  before_action :set_parent_category, only: [:new, :create, :edit, :update, :search]
  before_action :set_child_category, only: [ :edit, :update]
  before_action :set_grandchild_category, only: [ :edit, :update]

  def index
  end

  def show
    @product = Product.new
    @images = @product.images.order("id DESC")
    @seller = @product.seller
  end
end
