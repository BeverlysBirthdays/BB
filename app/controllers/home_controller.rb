class HomeController < ApplicationController

	# skip authorization for about_us page
	before_action :check_login, except: [:about_us]


	include HomeHelper
	
	def home
		@items_by_category = get_category_count
		@bins_by_agency = Bin.by_agency_and_program
		@items = Item.all.alphabetical
		@donated_items_count = calculate_total_donated_quantity(@items)
		@bins = Bin.all.chronological
		@agencies = Agency.all.alphabetical
	end

	def about_us
		
	end

end
