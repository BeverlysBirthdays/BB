class AddPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :unit_price, :decimal
  end
end
