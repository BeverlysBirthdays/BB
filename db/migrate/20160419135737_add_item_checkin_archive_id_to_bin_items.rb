class AddItemCheckinArchiveIdToBinItems < ActiveRecord::Migration
  def change
    add_column :bin_items, :item_checkin_archive_id, :integer
  end
end
