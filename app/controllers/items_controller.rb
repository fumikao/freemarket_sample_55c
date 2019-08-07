class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :seller, :edit, :update, :destroy]

  def index
    @ladies_categories = Category.where('ancestry LIKE(?)', "1/%")
    @ladies_items = Item.includes(:images).where(category_id: @ladies_categories.ids).order(created_at: :desc).limit(4)

    @mens_categories = Category.where('ancestry LIKE(?)', "2/%")
    @mens_items = Item.includes(:images).where(category_id: @mens_categories.ids).order(created_at: :desc).limit(4)

    @baby_categories = Category.where('ancestry LIKE(?)', "3/%")
    @baby_items = Item.includes(:images).where(category_id: @baby_categories.ids).order(created_at: :desc).limit(4)

    @cosme_categories = Category.where('ancestry LIKE(?)', "7/%")
    @cosme_items = Item.includes(:images).where(category_id: @cosme_categories.ids).order(created_at: :desc).limit(4)

    @chanel_items = Item.includes(:images).where(brand_id: 2441).order(created_at: :desc).limit(4)
    @vuitton_items = Item.includes(:images).where(brand_id: 6143).order(created_at: :desc).limit(4)
    @sup_items = Item.includes(:images).where(brand_id: 6759).order(created_at: :desc).limit(4)
    @nike_items = Item.includes(:images).where(brand_id: 3803).order(created_at: :desc).limit(4)
  end

  def new
    @categories = Category.where(ancestry: nil)
    @item = Item.new
    @item.images.build
  end

  def create
    @brand = Brand.find_by(name: params[:brand_name])
    @item = Item.new(item_params)
    if @item.save && image_params[:images].length != 0
      image_params[:images].each do |i|
        @item.images.create(image: i, item_id: @item.id)  
      end
      flash[:success] = "出品しました"
    else
      render 'items/new'
    end
  end
  
  def show
    @likes = Like.where(item_id: @item.id)
    @images = @item.images
    @image = @images.first
    @user = User.find(@item.seller_id)
    @brand = Brand.find(@item.brand_id) if @item.brand_id
    @category = Category.find(@item.category_id)
    @seller_items = Item.where(seller_id: @item.seller_id) .order(created_at: :DESC).limit(3)
    @category_items = Item.where(category_id: @item.category_id).order(created_at: :DESC).limit(3)
  end

  def seller
    @images = @item.images
    @image = @images.first
    @user = User.find(@item.seller_id)
    @brand = Brand.find(@item.brand_id) if @item.brand_id
    @category = Category.find(@item.category_id)
  end

  def edit
    grandchild = @item.category
    child = grandchild.parent
    parent = child.parent
    gon.category_grandchildren = child.children
    gon.category_children = parent.children
    gon.category_parents = Category.where(ancestry: nil)
    gon.category_grandchild = grandchild
    gon.category_child = child
    gon.category_parent = parent
    
    gon.brand = @item.brand

    gon.item = @item
    gon.images = @item.images

    require 'base64'
    require 'aws-sdk'

    gon.item_images_binary_datas = []
    if Rails.env.production?
      client = Aws::S3::Client.new(
                              region: 'ap-northeast-1',
                              access_key_id: ENV["AWS_ACCESS_KEY_ID"],
                              secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
                              )
      @item.images.each do |image|
        binary_data = client.get_object(bucket: 'o-freemarket', key: image.image.file.path).body.read
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    else
      @item.images.each do |image|
        binary_data = File.read(image.image.file.file)
        gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
      end
    end
  end

  def update
    @brand = Brand.find_by(name: params[:brand_name]) if params[:brand_name] != ""

    ids = @item.images.map{|image| image.id}
    exist_ids = registered_image_params[:ids].map(&:to_i)
    exist_ids.clear if exist_ids[0] == 0
    if @item.update(item_params) && (exist_ids.length != 0 || image_params[:images][0] != " ")
      unless ids.length == exist_ids.length
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.images.find(id).destroy
        end
      end

      unless image_params[:images][0] == " "
        image_params[:images].each do |image|
          @item.images.create(image: image, item_id: @item.id)
        end
      end
      flash[:success] = "編集しました"
    else
      render 'items/edit'
    end
  end

  def destroy
  end

  def set_children
    @category = Category.find(params[:parent_id])
    @children = @category.children
  end
  
  def set_grandchildren
    @children = Category.find(params[:child_id])
    @grandchildren = @children.children
  end

  def brand
    @brands = Brand.where('name LIKE(?)', "%#{params[:brand_input]}%" )
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    if @brand
      params.require(:item).permit(
        :name,
        :description,
        :condition,
        :shipping_fee,
        :shipping_method,
        :prefecture_id,
        :shipping_date,
        :price
        )
        .merge(category_id: params[:category_id])
        .merge(brand_id: @brand.id)
        .merge(seller_id: current_user.id).merge(status: 0)
    else
      params.require(:item).permit(
        :name,
        :description,
        :condition,
        :shipping_fee,
        :shipping_method,
        :prefecture_id,
        :shipping_date,
        :price
        )
        .merge(category_id: params[:category_id])
        .merge(brand_id: nil)
        .merge(seller_id: current_user.id).merge(status: 0)
    end
  end

  def image_params
    params.require(:images).permit({images: []})
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end
end