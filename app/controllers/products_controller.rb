class ProductsController < ApplicationController
  def index
  end
  
  def new
    @product = Product.new
    gon.count = 0
  end

  def create
  end

  def edit
  end
end