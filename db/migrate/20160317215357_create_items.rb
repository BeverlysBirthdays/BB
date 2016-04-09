class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :barcode
      t.integer :quantity, array: true
      t.string :name
      t.integer :gender
      t.integer :age, array: true
      t.boolean :type
      t.text :notes
      t.integer :category_id

      t.timestamps null: false
    end
    add_index :items, :age, using: 'gin'
    add_index :items, :quantity, using: 'gin'
  end
end
