class AddContactPersonToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :contact_person, :string
  end
end
