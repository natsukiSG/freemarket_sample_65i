class ProductsController < ApplicationController
  # before_action :set_parent_category, only: [:new, :create, :edit, :update, :search]
  # before_action :set_child_category, only: [ :edit, :update]
  # before_action :set_grandchild_category, only: [ :edit, :update]
  # before_action :set_sizes, only: [ :edit, :update]
  # skip_before_action :authenticate_user!, only: [:index, :show, :search, :get_searchsize, :get_category_children, :get_category_grandchildren]
  require "payjp"

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
    @product.image.build
    gon.count = 0
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

  def edit
    @product = Product.find(params[:id])
    gon.count = @product.images.length
    if @product.buyer_id != nil || @product.seller_id != current_user.id
      redirect_to root_path
    end
    @profit = (@product.price * 0.9).round
    @fee = @product.price - @profit
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

  def show
    @product = Product.find(params[:id])
    @seller = @product.seller
    @images = @product.images.order("id DESC")
    @category = @product.category
    @child = @category.parent
    @parent = @category.root
    @brand = @product.brand
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.seller_id == current_user.id
      @product.destroy
      redirect_to root_path, notice: '商品を削除しました'
    end
  end

  def buy_confirmation
      @product = Product.find(params[:id])
      if @product.buyer == nil && @product.seller != current_user.id
        @streetaddress = StreetAddress.find_by(user_id: current_user.id)
        card = Creditcard.where(user_id: current_user.id).first
        if Creditcard.present?
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          customer = Payjp::Customer.retrieve(card.customer_id)
          @default_card_information = customer.cards.retrieve(card.card_id)
        end
      else
        redirect_to root_path
    end
  end
    

    def pay
      @product = Product.find(params[:id])
      card = Creditcard.where(user_id: current_user.id).first
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      Payjp::Charge.create(
      :amount => @product.price, #支払金額を入力（itemテーブル等に紐づけても良い）
      :customer => card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    redirect_to action: 'done' #完了画面に移動
    end

  def search
    @searchsizes = Searchsize.all

    if params[:q].present?
    # 検索フォームからアクセスした時の処理
      @q = Product.includes(:brand,:size).ransack(search_params)
      @products = @q.result
    else
    # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @q = Product.ransack()
      @products = Product.all
      @namesearchs = Product.where('name LIKE(?)', "%#{params[:keyword]}%").limit(24)
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
  def  product_params
    params.require(:product).permit(:transaction_id, :name, :comment, :price, :status, :costcharge, :delivery_way, :delivery_area, :delivery_date, :category_id, :size_id, :brand_id, images_attributes: [:url]).merge(seller_id: current_user.id)
  end

  def delete_imgs
    if params.has_key?(:delete_ids)
      return params.require(:delete_ids)
    else
      return nil
    end
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

#   def set_parent_category
#     @category_parent_array = [{name:'---', id:'---'}]
#     Category.roots.each do |parent|
#       @parent = {name: parent.name, id: parent.id}
#       @category_parent_array << @parent
#     end
#   end

#   def set_child_category
#     @product = Product.find(params[:id])
#     @category_children_array = [{name:'---', id:'---'}]
#       (@product.category.root.children).each do |child|
#         @children = {name: child.name, id: child.id}
#         @category_children_array << @children
#       end
#   end

#   def set_grandchild_category
#     @category_grandchildren_array = [{name:'---', id:'---'}]
#     (@product.category.parent.children).each do |grandchild|
#       @grandchildren = {name:grandchild.name, id:grandchild.id}
#       @category_grandchildren_array << @grandchildren
#     end
#   end

#   def set_sizes
#     @sizes_array = [{name:'---', id:'---'}]
#     (@product.category.sizes).each do |size|
#       @size = {name: size.name, id: size.id}
#       @sizes_array << @size
#     end
#   end
 end
