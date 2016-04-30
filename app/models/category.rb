class Category < ActiveRecord::Base

	# Relationships
	has_many :items

	# Scope
	scope :alphabetical,  -> { order("name") } 
	#group by program and order

	# Validations
	validates_presence_of :name, :icon
	validates_uniqueness_of :name, :icon

	# Callbacks
	before_save :capitalize_category

	# Private methods
	private 
	def capitalize_category
	  self.name = self.name.titleize
	  self.icon = self.icon.capitalize 
	end

end
