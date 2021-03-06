class SearchesController < ApplicationController
  before_action :search_preparation

  def fuzzy_search
    @keyword = params[:q][:name_cont]
    tmp = Item.search(fuzzy_search_params)
    #検索結果を本家同様1ページに132件までしか表示しない
    @items = tmp.result.limit(132)
  end

#詳細検索結果表示
  def detail_search
    @keyword = params[:q][:name_cont]
    tmp = Item.search(detail_search_params)
    @items = tmp.result
  end

  private
  #検索の入力画面表示のために各パラメーター準備
  def search_preparation
    @q = Item.ransack(params[:q])
    @categories = Category.where(ancestry: nil)
    #カテゴリ表示用の読み込み
    @category_list = Category.all
  end

  #あいまい検索用
  def fuzzy_search_params
    params.require(:q).permit(:name_cont)
  end
  
  #詳細検索用
  def detail_search_params
    params.require(:q)
    .permit(:name_or_category_name_or_brand_name_cont,
            {category_id_in: []}, 
            :brand_name_cont, 
            :price_gteq, 
            :price_lteq, 
            {condition_in: []}, 
            {shipping_fee_in: []}, 
            {status_in: []})
  end
end
