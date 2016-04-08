class Program < ActiveRecord::Base

	# Relationships
	belongs_to :bin

	# Scopes 
    scope :alphabetical, -> { order(:name) }
end
