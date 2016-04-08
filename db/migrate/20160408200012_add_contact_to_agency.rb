class AddContactToAgency < ActiveRecord::Migration
  def change
  	add_column :agencies, :phone, :string
  	add_column :agencies, :street, :string
  	add_column :agencies, :city, :string
  	add_column :agencies, :state, :string
  	add_column :agencies, :zip, :string
  	add_column :agencies, :email, :string
  end
end
