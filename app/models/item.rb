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
	    # :by_donation,
	    # :by_bought
	  ]
	)
	
	# Relationships
	belongs_to :category
	has_many :bin_items
	has_many :bins, through: :bin_items

	# Virtual Attributes
	attr_accessor :donated
	attr_accessor :check_in_quantity

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

	# stock
	# scope :by_asc_count, -> { order("quantity ASC")}
	# scope :by_desc_count, -> { order("quantity DESC")}
	# scope :for_low_stock, -> { where("quantity <= ?", MINIMUM)}
	# scope :not_in_stock, -> { where("quantity = ?", 0)}
	# scope :in_stock, -> { where('total_quantity > ?', 0)}

	# donations vs. self-bought
	# scope :by_donation, -> {where('quantity[0]!=0') }
	# scope, :by_bought, -> {where('quantity[1]!=0')}


	# # donation = True
	# scope :by_donation, -> { where("name && ARRAY[0]")}
	# # Self_bought = False
	# scope :by_self_bought, -> { where("name && ARRAY[1]")} 
	# scope :by_donation, -> {where(donated: true)}
	# scope, :by_self_bought, -> {where(donated: false)}

	# Validations
	validates_presence_of :name, :category_id, :age, :donated_quantity, :bought_quantity
	validates_inclusion_of :gender, in: GENDER_LIST.to_h.values, message: "must be selected from given options"
	# validates_inclusion_of :age, in: AGE_LIST.to_h.values, message: "is not an option"
	validates_numericality_of :donated_quantity, only_integer: true, greater_than_or_equal_to: 0
	validates_numericality_of :bought_quantity, only_integer: true, greater_than_or_equal_to: 0
	validate :age_is_in_list
	# validates presence of price if bought
	validates_presence_of :unit_price, if: '!is_donated?'

	# Other methods

	def total_quantity
		return self.donated_quantity + self.bought_quantity
	end
	def low_stock
		where(total_quantity <= MINIMUM)
	end
	def in_stock
	 	total_quantity > 0
	end

	def total_inventory_value
		if unit_price.nil?
			return 'N.A'
		else
			return self.total_quantity * self.unit_price
		end
	end

	def is_donated?
		donated=='1'
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
