class AddNumOfBinsToBins < ActiveRecord::Migration
  def change
    add_column :bins, :num_of_bins, :integer
  end
end
