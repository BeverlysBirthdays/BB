class CreateItemCheckins < ActiveRecord::Migration
  def change
    create_table :item_checkins do |t|
      t.integer :quantity_checkedin
      t.integer :quantity_remaining
      t.float :unit_price
      t.boolean :donated
      t.date :checkin_date
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
