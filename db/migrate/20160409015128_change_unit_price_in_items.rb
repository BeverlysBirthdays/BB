class ChangeUnitPriceInItems < ActiveRecord::Migration
  def change
  	change_column :items, :unit_price, :float
  end
end
