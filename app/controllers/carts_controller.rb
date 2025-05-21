class CartsController < ApplicationController
  def show
    @cart = (session[:cart] || {}).transform_keys(&:to_i)
  end

  def add_item
    session[:cart] ||= {}
    session[:cart][params[:product_id]] ||= 0
    session[:cart][params[:product_id]] += 1
    redirect_to cart_path, notice: "Item added"
  end

  def remove_item
    session[:cart]&.delete(params[:product_id])
    redirect_to cart_path, notice: "Item removed"
  end
end
