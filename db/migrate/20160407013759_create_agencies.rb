class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
