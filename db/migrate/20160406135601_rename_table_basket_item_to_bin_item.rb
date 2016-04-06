class RenameTableBasketItemToBinItem < ActiveRecord::Migration
  def change
  	rename_table :basket_items, :bin_items
  end
end
