class RemoveDonatedFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :donated, :boolean
  end
end
