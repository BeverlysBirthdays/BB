class Program < ActiveRecord::Base

	# Relationships
	has_many :bins

	# Scopes 
    scope :alphabetical, -> { order(:name) }

    # Validations
    validates_uniqueness_of(:name)

    # Callbacks
    before_save :capitalize_program

    private
    def capitalize_program
    	self.name = self.name.titleize
    end

end
