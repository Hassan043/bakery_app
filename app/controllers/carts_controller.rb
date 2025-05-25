class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
  end
  def add_item
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0 # Default to 1 if no quantity or invalid quantity
    
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity
    
    product = Product.find(product_id)
    redirect_to cart_path, notice: "#{quantity} x #{product.name} added to cart"
  end

  def increase_item
    product_id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    
    product = Product.find(product_id)
    redirect_to cart_path, notice: "Increased #{product.name} quantity"
  end

  def decrease_item
    product_id = params[:product_id].to_s
    if session[:cart] && session[:cart][product_id]
      session[:cart][product_id] -= 1
      
      if session[:cart][product_id] <= 0
        session[:cart].delete(product_id)
        product = Product.find(product_id)
        redirect_to cart_path, notice: "#{product.name} removed from cart"
      else
        product = Product.find(product_id)
        redirect_to cart_path, notice: "Decreased #{product.name} quantity"
      end
    else
      redirect_to cart_path, alert: "Item not found in cart"
    end
  end

  def remove_item
    product_id = params[:product_id].to_s
    if session[:cart] && session[:cart][product_id]
      product = Product.find(product_id)
      session[:cart].delete(product_id)
      redirect_to cart_path, notice: "#{product.name} removed from cart"
    else
      redirect_to cart_path, alert: "Item not found in cart"
    end
  end

  def clear_cart
    session[:cart] = {}
    redirect_to cart_path, notice: "Cart cleared successfully"
  end
end
