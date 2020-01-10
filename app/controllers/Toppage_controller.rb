class ToppageController < ApplicationController
  def index
    @ladies_items = Product.where(category_id: 1...199).order("created_at DESC").limit(10)
    @mens_items = Product.where(category_id: 199...341).order("created_at DESC").limit(10)
    @electro_items = Product.where(category_id: 889...975).order("created_at DESC").limit(10)
    @toy_items = Product.where(category_id: 676...789).order("created_at DESC").limit(10)

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

  def edit
    @product = Product.find(params[:id])
    gon.count = @product.images.length
    if @product.buyer_id != nil || @product.seller_id != current_user.id
      redirect_to root_path
    end
    @profit = (@product.price * 0.9).round
    @fee = @product.price - @profit
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


  def set_parent_category
    @category_parent_array = [{name:'---', id:'---'}]
    Category.roots.each do |parent|
      @parent = {name: parent.name, id: parent.id}
      @category_parent_array << @parent
    end
  end

  def set_child_category
    @product = Product.find(params[:id])
    @category_children_array = [{name:'---', id:'---'}]
      (@product.category.root.children).each do |child|
        @children = {name: child.name, id: child.id}
        @category_children_array << @children
      end
  end

  def set_grandchild_category
    @category_grandchildren_array = [{name:'---', id:'---'}]
    (@product.category.parent.children).each do |grandchild|
      @grandchildren = {name:grandchild.name, id:grandchild.id}
      @category_grandchildren_array << @grandchildren
    end
  end

  def set_sizes
    @sizes_array = [{name:'---', id:'---'}]
    (@product.category.sizes).each do |size|
      @size = {name: size.name, id: size.id}
      @sizes_array << @size
    end
  end
end