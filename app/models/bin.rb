class Bin < ActiveRecord::Base

	# Relationships
	has_many :bin_items
	has_many :items, through: :bin_items

	# Scopes
	scope :chronological, -> { order ("checkout_date DESC") }
	# scope :for_date, -> (d) { where ("checkout_date = ?", d) }

	# Validations
	validates_date :checkout_date

end
