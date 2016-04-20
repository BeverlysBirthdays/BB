class Bin < ActiveRecord::Base

	filterrific(
	  default_settings: { sorted_by: 'checkout_date' },
	  available_filters: [
	    :sorted_by,
	    :search_by_agency,
	    :search_by_date_gte,
	    :search_by_date_lte,
	    :search_by_program
	  ]
	)

	# Relationships
	belongs_to :program
	has_many :bin_items
	has_many :items, through: :bin_items
	belongs_to :agency

	# Scopes
	scope :sorted_by, -> { order ("checkout_date DESC") }
	scope :chronological, -> { order ("checkout_date DESC") }
	scope :by_agency_and_program, -> {group('agency_id', 'program_id').sum('num_of_bins')}

	scope :search_by_agency, -> (a){joins(:agency).where('agencies.name = ?', a)}
	scope :search_by_date_gte, -> (d){where("checkout_date>=?", d)}
	scope :search_by_date_lte, -> (d){where("checkout_date<=?", d)}
	scope :search_by_program, -> (p) { joins(:program).where('programs.name = ?', p) }
	
	# Validations
	validates_date :checkout_date, :on => :today
	validates_numericality_of :num_of_bins, only_integer: true, greater_than_or_equal_to: 1

	# Methods
	def get_unique_items_and_quantity_per_bin()
		d = {}
		self.bin_items.each do |b|
			# either item_Checkin or item_checkin_Archive: both are mutually exclusive, i.e. one has to be null
			if !b.item_checkin.nil?
				item_id = b.item_checkin.item_id
			else
				item_id = b.item_checkin_archive.item_id
			end

			# update quantity for given item
			if d.keys().include?(item_id)
				d[item_id] += b.quantity
			else
				d[item_id] = b.quantity
			end 
		end
		return d
	end

end
