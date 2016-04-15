class RemoveQuantityAndPriceFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :donated_quantity, :integer
    remove_column :items, :bought_quantity, :integer
    remove_column :items, :unit_price, :float
  end
end
