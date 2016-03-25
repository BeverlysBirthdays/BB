class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :barcode
      t.integer :quantity
      t.string :name
      t.integer :gender, array: true
      t.integer :age
      t.boolean :type
      t.text :notes
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :items, :gender, using: 'gin'
  end
end
