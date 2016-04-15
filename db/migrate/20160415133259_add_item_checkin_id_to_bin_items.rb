class AddItemCheckinIdToBinItems < ActiveRecord::Migration
  def change
    add_column :bin_items, :item_checkin_id, :integer
  end
end
