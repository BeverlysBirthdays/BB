module HomeHelper
	# helper methods
	def calculate_total_quantity(items)
		total_quantity = 0
		items.each do |i|
			total_quantity+=i.total_quantity
		end
		return total_quantity
	end

	def calculate_total_donated_quantity(items)
		total_donated_quantity = 0
		items.each do |i|
			total_donated_quantity+=i.total_donated_quantity
		end
		return total_donated_quantity
	end

	def get_category_count
		@items_by_category = Array.new
		@categories = Category.all.alphabetical
		# get total quantity for all items belonging to a particular category
		@categories.each do |c|
			@items = Item.by_category(c.name)
			total_quantity = calculate_total_quantity(@items)
			total_donated_quantity = calculate_total_donated_quantity(@items)
			total_bought_quantity =total_quantity- total_donated_quantity
			info = {category: c.name, total_quantity: total_quantity, total_donated_quantity: total_donated_quantity, total_bought_quantity: total_bought_quantity}
			@items_by_category << info
		end
		return @items_by_category
	end

end
