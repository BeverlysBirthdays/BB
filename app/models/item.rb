class Item < ActiveRecord::Base

	# get an array of gender types
	GENDER_LIST = [['Neutral', 0], ['Girl', 1], ['Boy', 2]]
	# get an array of age category (in years)
	AGE_LIST = [['0-2', 0], ['3-10', 1], ['11-21', 2]]
	# Minimum number of items in stock = 10
	MINIMUM = 10

	filterrific(
	  default_settings: { sorted_by: 'name' },
	  available_filters: [
	    :sorted_by,
	    :search_by_name,
	    :search_by_barcode,
	    :by_gender,
	    :by_age_category,
	    :by_category,
	    :search_by_quantity
	  ]
	)
	
	# Relationships
	belongs_to :category
	has_many :bin_items
	has_many :item_checkins
	has_many :item_checkin_archives

	# Virtual Attributes
	attr_accessor :donated, :check_in_quantity, :unit_price

	# Scopes
	scope :sorted_by, lambda { order('name') }
	scope :alphabetical,  -> { order('name') }
	# by gender
	scope :by_gender, -> (g){ where(gender: g) }
	# by age
	scope :by_age_category, -> (c){ where("age && ARRAY[?]", c.to_i)}
	# by category
	scope :by_category, -> (c) {joins(:category).where("categories.name = ?", c)}
	# by name
	scope :search_by_name, -> (name) { where("name LIKE ? OR notes LIKE ?", "%" + name + "%", "%"+name+"%") }
	# by barcode
	scope :search_by_barcode, -> (b) { where("barcode = ? ", b.to_s)}

	# Validations
	validates_presence_of :name, :category_id, :age
	validates_inclusion_of :gender, in: GENDER_LIST.to_h.values, message: "must be selected from given options"
	validate :age_is_in_list
	validates_presence_of :unit_price, if: '!is_donated?'


	# Custom Methods
	# total quantity in inventory currently
	def total_quantity_remaining
		self.item_checkins.sum('quantity_remaining')
	end
	def total_donated_quantity_remaining
		self.item_checkins.where(donated: true).sum('quantity_remaining')
	end
	def total_bought_quantity_remaining
		self.item_checkins.where(donated: false).sum('quantity_remaining')
	end

	# total value of inventory remaining
	def total_quantity_remaining_value
		total = 0
		# self.item_checkins.each do |ic|
		# 	if !ic.unit_price.nil?
		# 		total += (ic.unit_price * ic.quantity_remaining)
		# 	elsif 
		# 	end
		# end

		ics = self.item_checkins
		total = 0
		ics.length.times do |i|
			if !ics[i].unit_price.nil?
				total += (ics[i].unit_price * ics[i].quantity_remaining)
			elsif i>0 && !ics[i-1].unit_price.nil?
				total += (ics[i-1].unit_price * ics[i-1].quantity_remaining)
			elsif i<ics.length-1 && !ics[i+1].unit_price.nil?
				total += (ics[i+1].unit_price * ics[i+1].quantity_remaining)
			end
		end
		if total==0
			return 'N.A'
		else 
			return total
		end

	end
	def total_bought_quantity_remaining_value
		self.item_checkins.where(donated: false).sum('quantity_remaining * unit_price')
	end	

	# total quantity checked in to inventory
	def total_quantity_checkedin
		self.item_checkins.sum('quantity_checkedin') + self.item_checkin_archives.sum('quantity_checkedin')
	end
	def total_donated_quantity_checkedin
		self.item_checkins.where(donated: true).sum('quantity_checkedin') + self.item_checkin_archives.where(donated: true).sum('quantity_checkedin')
	end

	# Methods used in scopes
	def is_donated?
		donated != "0"
	end

	# Methods = scope
	def self.search_by_quantity(min)
		low_stock = Array.new
		a = Item.joins(:item_checkins).group('item_id').sum('quantity_remaining')
		a.keys.each do |item_id|
			if a[item_id] <= min
				low_stock << item_id
			end
		end
		return low_stock
	end

	# get data to dump from db to csv
	def self.dump_to_csv
		@items = Item.alphabetical
	end
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
		    csv << ['Item ID', 'Item Barcode', 'Item Name', 'Age', 'Gender', 'Notes', 'Category', 'Quantity Checked In', 'Quantity Remaining', 'Unit Price', 'Donated', 'Check-in Date']
		    all.each do |item|

		    	info = []
		    	# item specific info:

	    		# get string version for age instead of integer
	    		age=Array.new
	    		item.age.each do |a|
	    			age << AGE_LIST[a][0]
	    		end

	    		info = [item.id, item.barcode, item.name, age, GENDER_LIST[item.gender][0], item.notes, item.category.name]

		    	# item_checkins for items
		    	item.item_checkins.each do |ic|

		    		info += [ic.quantity_checkedin, ic.quantity_remaining, ic.unit_price, ic.donated, ic.checkin_date]

		    	end
		    	# item_checkin_archives for items
		    	item.item_checkin_archives.each do |ic|

		    		info += [ic.quantity_checkedin, 0, ic.unit_price, ic.donated, ic.checkin_date]

		    	end
		    	csv << info

		    end
	  	end
	end

	private
	def age_is_in_list
		if ! self.age.nil?
		# 	errors.add(:age, "can't be blank")
		# else
			age_values_list = []
			# get integer values for all age groups
			for age_group in AGE_LIST
				age_values_list+=[age_group[1]]
			end
			# check if age value entered is in age group list
			for i in self.age
				if age_values_list.include?(i) == false
					return false
				end
			end
			return true
		end
	end

end
