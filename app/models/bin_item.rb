class BinItem < ActiveRecord::Base

	# Relationships
	belongs_to :bin 
	belongs_to :item_checkin
	belongs_to :item_checkin_archive

	# Validations
	validates_numericality_of :quantity, only_integer: true, greater_than: 0
	# validate :item_in_inventory

	# Scopes

	# Methods
	private
	def item_in_inventory

		if !self.item_checkin.in_stock
			errors.add(:item, "is not in stock")
		end

		# if !self.item.in_stock
		# 	errors.add(:item, "is not in stock")
		# end
		# all_item_ids = Item.in_stock.map(&:id)
		# unless all_item_ids.include?(self.item_id)
		# 	errors.add(:item, "is not in stock")
		# end
	end

end
