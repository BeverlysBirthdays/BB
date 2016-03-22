module ItemsHelper

	# get gender list for index view of items page
	def get_gender_list
		Item::GENDER_LIST
	end

	# get age list for index view of items page
	def get_age_list
	 	Item::AGE_LIST 
	end 

end
