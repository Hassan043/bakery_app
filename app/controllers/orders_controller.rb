class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    cart = (session[:cart] || {}).transform_keys(&:to_i)
    @order = current_user.orders.build(status: :pending, total: 0)
    cart.each { |pid, qty|
      p = Product.find(pid)
      @order.order_items.build(product: p, quantity: qty, price: p.price)
      @order.total += p.price * qty
    }
    if @order.save
      session[:cart] = {}
      redirect_to @order, notice: "Order placed!"
    else
      redirect_to cart_path, alert: "Unable to place order."
    end
  end
end
