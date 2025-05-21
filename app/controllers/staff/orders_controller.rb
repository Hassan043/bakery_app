class Staff::OrdersController < ApplicationController
  before_action :require_staff_or_admin!

  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to staff_orders_path, notice: "Order status updated"
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def require_staff_or_admin!
    redirect_to root_path, alert: "Unauthorized" unless current_user.staff? || current_user.admin?
  end
end
