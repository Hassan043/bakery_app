class AddImagePathAndQuantityToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :image_path, :string
    add_column :products, :quantity, :integer
  end
end
