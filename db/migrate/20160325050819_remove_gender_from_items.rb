class RemoveGenderFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :gender, :integer
  end
end
