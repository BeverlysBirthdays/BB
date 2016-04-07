class Agency < ActiveRecord::Base

	# Relationships
	has_many :bins

	# Validations
	validates_presence_of :name

	# Scope
	scope :alphabetical,  -> { order('name') }
	scope :active, -> { where(active: true) }
	scope :inactive, -> {where(active: false)}

end
