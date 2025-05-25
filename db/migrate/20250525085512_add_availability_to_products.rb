class AddAvailabilityToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :availability, :boolean
  end
end
