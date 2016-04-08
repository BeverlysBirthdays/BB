class AddProgramIdToBins < ActiveRecord::Migration
  def change
  	add_column :bins, :program_id, :integer
  end
end
