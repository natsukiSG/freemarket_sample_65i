class ProductsController < ApplicationController
  before_action :set_parent_category, only: [:new, :create, :edit, :update, :search]
  before_action :set_child_category, only: [ :edit, :update]
  before_action :set_grandchild_category, only: [ :edit, :update]
  before_action :set_sizes, only: [ :edit, :update]

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
    binding.pry
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

  def update
    @product = Product.find(params[:id])
    image_del_list = delete_imgs if delete_imgs
    if @product.update(product_params)
      if (params[:images] != nil)
        params[:images]['url'].each do |image|
          @product.images.create(url: image, product_id: @product.id)
        end
        if image_del_list
          image_del_list.each do |image_id|
            Image.find(image_id).destroy
          end
        end
        redirect_to root_path
      else
        if image_del_list
          image_del_list.each do |image_id|
            Image.find(image_id).destroy
          end
        end
        if @product.images.length == 0
          redirect_to edit_product_path
        else
          redirect_to root_path
        end
      end
    else
      redirect_to edit_product_path
    end
  end

  private
  def  product_params
    params.require(:product).permit(:name, :comment, :price, :costcharge, :delivery_way, :delivery_area, :delivery_date, :category_id,)
  end
  
  def search_params
    if params[:grandchild].present?
      category_ids = params[:grandchild]
    elsif params[:child].present?
      @category = Category.find(params[:child])
      category_ids = @category.descendant_ids
    end

    params.require(:q).permit(
      :sorts,
      :name_cont,
      :category_name_not_eq,
      :brand_name_cont,
      :price_gteq,
      :price_lteq,
      { status_in: [] },
      { costcharge_in: [] },
      { size_id_in: [] },
      { transaction_id_in: [] }
    ).merge(category_id_in: category_ids)
  end

  def set_parent_category
    @category_parent_array = [{name:'---', id:'---'}]
    Category.roots.each do |parent|
      @parent = {name: parent.name, id: parent.id}
      @category_parent_array << @parent
    end
  end
end
