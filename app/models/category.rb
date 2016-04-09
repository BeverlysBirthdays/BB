class Category < ActiveRecord::Base

	# Relationships
	has_many :items

	# Scope
	scope :alphabetical,  -> { order("name") } 
	#group by program and order

	# Validations
	validates_presence_of :name, :icon
	validates_uniqueness_of :name, :icon

	# Other methods
	

end
