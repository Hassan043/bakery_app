class Admin::DashboardController < ApplicationController
  before_action -> { redirect_to root_path unless current_user.admin? }

  def index
    @total_sales     = Order.completed.sum(:total)
    @pending_orders  = Order.pending.count
    @low_stock_items = Inventory.where("quantity <= low_stock_threshold")
  end
end
