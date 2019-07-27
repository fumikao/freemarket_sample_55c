class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'items/new'
    end
  end
  
  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :status,
      :shipping_fee,
      :shipping_date,
      :price,
      images_attributes: [:image, :item_id]).merge(seller_id: 1)
  end
end