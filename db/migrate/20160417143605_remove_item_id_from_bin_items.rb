class RemoveItemIdFromBinItems < ActiveRecord::Migration
  def change
    remove_column :bin_items, :item_id, :integer
  end
end
