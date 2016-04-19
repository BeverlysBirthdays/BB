class HomeController < ApplicationController

	include HomeHelper
	
	def home
		@items_by_category = get_category_count
		render 'admin_home'
	end

end
