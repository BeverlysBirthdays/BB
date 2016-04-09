class AddBoughtQuantityToItems < ActiveRecord::Migration
  def change
    add_column :items, :bought_quantity, :integer
  end
end
