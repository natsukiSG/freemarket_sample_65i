class ToppageController < ApplicationController
  before_action :set_parent_category, only: [:new, :create, :edit, :update, :search]
  before_action :set_child_category, only: [ :edit, :update]
  before_action :set_grandchild_category, only: [ :edit, :update]
  before_action :set_sizes, only: [ :edit, :update]
  skip_before_action :authenticate_user!, only: [:index, :show, :search, :get_searchsize, :get_category_children, :get_category_grandchildren]
  require "payjp"

  def index
    @ladies_items = Product.where(category_id: 1...199).order("created_at DESC").limit(10)
    @mens_items = Product.where(category_id: 199...341).order("created_at DESC").limit(10)
    @electro_items = Product.where(category_id: 889...975).order("created_at DESC").limit(10)
    @toy_items = Product.where(category_id: 676...789).order("created_at DESC").limit(10)
    @chanel_brands = Product.where(brand_id: 2447).order("created_at DESC").limit(10)
    @louis_brands = Product.where(brand_id: 6155).order("created_at DESC").limit(10)
    @sup_brands = Product.where(brand_id: 7959).order("created_at DESC").limit(10)
    @nike_brands = Product.where(brand_id: 3813).order("created_at DESC").limit(10)
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
    @product.images.build
    gon.count = 0
  end

  def show
    @product = Product.find(params[:id])
    @seller = @product.seller
    @images = @product.images.order("id DESC")
    @category = @product.category
    @child = @category.parent
    @parent = @category.root
    @brand = @product.brand
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


  def destroy
    @product = Product.find(params[:id])
    if @product.seller_id == current_user.id
      if @product.destroy
        redirect_to root_path, notice: "「#{@product.name}を削除しました。」"
      else
        redirect_to toppage_path(@product.id), notice: "「#{@product.name}の削除ができませんでした。」"
      end
    end
  end

  
  def get_category_children
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_size
    @sizes = Category.find("#{params[:grandchild_id]}").sizes

  end

  def get_brand
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
  end

  def get_searchsize
    @searchsizes = Searchsize.find("#{params[:searchsize_id]}").sizes
  end

  private

  def set_parent_category
    @category_parent_array = [{name:'---', id:'---'}]
    Category.roots.each do |parent|
      @parent = {name: parent.name, id: parent.id}
      @category_parent_array << @parent
    end
  end

  
end