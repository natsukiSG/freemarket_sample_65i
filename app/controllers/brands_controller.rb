class BrandsController < ApplicationController

  def index
    @brand_categories = BrandCategory.all

  end

  def show
    @brand = Brand.find(params[:id])
    @products = @brand.products
  end
end
