class CreateItemCheckinArchives < ActiveRecord::Migration
  def change
    create_table :item_checkin_archives do |t|
      t.integer :quantity_checkedin
      t.float :unit_price
      t.boolean :donated
      t.date :checkin_date
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
