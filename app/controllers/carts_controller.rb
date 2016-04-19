class CartsController < ApplicationController

	include BbInventoryHelpers::Cart

	def add_to_cart()
		# render item quantity form
		id = params[:id]
		redirect_to get_quantity_for_item_path(id)
	end

	def get_quantity_for_item()
		@item = Item.find(params[:id])
	end

	def add_item_and_quantity_to_cart
		@item = Item.find(params[:id])
		
		@qty = params[:qty].to_i

		@item_checkins = ItemCheckin.checkins_for_item(@item.id)
		@total_quantity_for_item = @item_checkins.sum('quantity_remaining')

		if @item_checkins.nil? or @total_quantity_for_item<@qty 
			flash[:error] = 'Required quantity not in stock. Stock Available: '+ @total_quantity_for_item.to_s
			redirect_to get_quantity_for_item_path(params[:id])
		else
			add_item_to_cart(@item.id.to_i, @qty.to_i)
			redirect_to show_cart_path
		end

	end

	def show_cart
		if session[:cart].nil?
			create_cart
		end
		
		@bin_items_in_cart = get_list_of_items_in_cart

		# @cart_total = calculate_cart_items_cost
		# @cart_shipping_cost = calculate_cart_shipping
		# @grand_total = @cart_shipping_cost + @cart_total
		render 'show_cart'
	end

	def remove_item
		@item = Item.find(params[:id])
		remove_item_from_cart(@item.id)
		redirect_to show_cart_path
	end

	def clear
		clear_cart
		redirect_to items_path, notice: "Cleared cart"
	end

end
