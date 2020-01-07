class BrandCategoriesController < ApplicationController
  def show
    @brand_categories = BrandCategory.all
    @category = BrandCategory.find(params[:id])
  end
end