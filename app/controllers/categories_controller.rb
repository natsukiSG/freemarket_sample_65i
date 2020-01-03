class CategoriesController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil).order("id ASC")
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category.subtree).order("created_at DESC")
  end

  def get_category_children
    #子カテゴリーの配列を取得
    @children = Category.find(params[:parent_id]).children.limit(14)
  end

  def get_category_grandchildren
    #孫カテゴリーの配列を取得
    @grandchildren = Category.find(params[:child_id]).children.limit(14)
  end

end
