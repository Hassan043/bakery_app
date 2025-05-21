class InventoriesController < ApplicationController
  before_action :require_admin!

  def index
    @inventories = Inventory.includes(:product).all
  end

  def update
    inv = Inventory.find(params[:id])
    inv.update!(inventory_params)
    redirect_to inventories_path, notice: "Stock updated"
  end

  private

  def inventory_params
    params.require(:inventory).permit(:quantity, :low_stock_threshold)
  end

  def require_admin!
    redirect_to root_path, alert: "Unauthorized" unless current_user.admin?
  end
end
