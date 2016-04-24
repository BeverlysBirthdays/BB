class Program < ActiveRecord::Base

	# Relationships
	has_many :bins

	# Scopes 
    scope :alphabetical, -> { order(:name) }

    # Validations
    validates_uniqueness_of(:name)

end
