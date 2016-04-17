class ItemCheckin < ActiveRecord::Base

	# Relationships
	belongs_to :item
	has_one :bin_item

	# Validations
	validates_numericality_of :quantity_checkedin, only_integer: true, greater_than_or_equal_to: 0
	validates_numericality_of :quantity_remaining, only_integer: true, greater_than_or_equal_to: 0
	validates_date :checkin_date
	validates_presence_of :unit_price, if: '!is_donated?'

	# Scopes
	scope :by_donated, -> {where(donated: true)}
	scope :by_bought, -> {where(donated: false)}
	# get chronological listing of item_checkins for each item
	scope :checkins_for_item, -> (i){where('item_id=?',i).order('checkin_date')}
	# get total quantity for each item
	scope :total_quantity_for_item, -> (i){group('item_id').having('item_id = ?', i).sum('quantity_remaining')}
	scope :total_quantity, -> {group('item_id').sum('quantity_remaining')}
	scope :total_donated_quantity, -> {group('item_id').having(donated: true).sum('quantity_remaining')}

	# Methods
	def is_donated?
		donated == true
	end

	def total_value
		if unit_price.nil?
			return 'N.A'
		else
			return quantity_checkedin*unit_price
		end
	end

	# check if item in stock
	def in_stock
		ItemCheckin.where (total_quantity > 0)
	end

end
