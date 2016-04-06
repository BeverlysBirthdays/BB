class RenameTable < ActiveRecord::Migration
  def change
  	rename_table :baskets, :bins
  end
end
