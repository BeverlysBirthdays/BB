class Item < ActiveRecord::Base

	# get an array of gender types
	GENDER_LIST = [['Neutral', 0], ['Girl', 1], ['Boy', 2]]
	# get an array of age category (in years)
	AGE_LIST = [['0-2', 0], ['3-10', 1], ['11-21', 2]]
	# Minimum number of items in stock = 10
	MINIMUM = 10
	
	# Relationships
	belongs_to :category
	has_many :basket_items
	has_many :baskets, through: :basket_items

	# Scopes
	scope :alphabetical,  -> { order("name.downcase") }
	# by gender
	scope :for_neutral, -> { where(gender: 0)} # neutral
	scope :for_girl, -> { where(gender: 1)} # girl
	scope :for_boy, -> { where(gender: 2)} # boy
	scope :by_gender, -> (g){ where("gender = ?", g) }
	# by age
	scope :for_baby, -> { where(age: 0)} # 0-2 years
	scope :for_pre_teen, -> { where(age: 1)} # 3-10 years
	scope :for_teen, -> { where(age: 2)} # 11-21 years
	scope :for_age_category, -> (c){ where("age = ?", c)}
	# by name
	scope :search_by_name, -> (name) { where("name LIKE ?", "%" + name + "%")}
	# by barcode
	scope :search_by_barcode, -> (b) { where("barcode = ", b)}
	# stock
	scope :by_asc_count, -> { order("quantity ASC")}
	scope :by_desc_count, -> { order("quantity DESC")}
	scope :for_low_stock, -> { where("quantity <= ?", MINIMUM)}
	scope :not_in_stock, -> { where("quantity = ?", 0)}
	scope :in_stock, -> { where("quantity > ?", 0)}
	# donations vs. self-bought
	scope :by_donation, -> { where(donated: true)} # donation = True
	scope :by_self_bought, -> { where(donated: false)} # Self_bought = False

	# Validations
	validates_presence_of :name, :quantity
	validates_inclusion_of :gender, in: GENDER_LIST.to_h.values, message: "is not an option"
	validates_inclusion_of :age, in: AGE_LIST.to_h.values, message: "is not an option"
	validates_numericality_of :quantity, only_integer: true, greater_than_or_equal_to: 1, on: :create
	validates_numericality_of :quantity, only_integer: true, greater_than_or_equal_to: 0, on: :update

	# Other methods
	def increase_quantity (incr)
		self.quantity += incr
	end

end
