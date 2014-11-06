class StoreController < ApplicationController
  before_action :find_store

  def index
    find_all_products
  end

  def show
    @product = find_product
  end


  private
  def find_store
    puts
    @store = Store.find_by_name(params[:id])
  end

  def find_all_products
    category_id = params[:category_id]
    @products = category_id.present? ? Product.where(category_id: category_id) : Product.all
    @products.each { |p| p.rmb_price = (p.price * @store.exchange_rate * (100 + @store.price_factor)/10000).ceil}
  end

  def find_product
    @product = Product.find(params[:product_id])
    @product.rmb_price = (@product.price * @store.exchange_rate * (100 + @store.price_factor)/10000).ceil
    @product
  end
end