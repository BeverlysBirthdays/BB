class HomeController < ApplicationController

	# skip authorization for about_us page
	before_action :check_login, except: [:about_us]


	include HomeHelper
	
	def home
		@items_by_category = get_category_count
		@bins = Bin.all
		@agencies = Agency.all
		@bins_by_agency = Bin.by_agency_and_program
		@item_count = calculate_total_quantity(Item.all.alphabetical)
		@donation_count = calculate_total_donated_quantity(Item.all.alphabetical)
	end

	def about_us
		
	end

end
