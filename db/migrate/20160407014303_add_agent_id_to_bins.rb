class AddAgentIdToBins < ActiveRecord::Migration
  def change
    add_column :bins, :agency_id, :integer
  end
end
