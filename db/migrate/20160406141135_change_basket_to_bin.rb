class ChangeBasketToBin < ActiveRecord::Migration
  def change
  	remove_column :bin_items, :basket_id, :integer
  	add_column :bin_items, :bin_id, :integer
  end
end
