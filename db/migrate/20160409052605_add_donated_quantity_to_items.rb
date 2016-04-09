class AddDonatedQuantityToItems < ActiveRecord::Migration
  def change
    add_column :items, :donated_quantity, :integer
  end
end
