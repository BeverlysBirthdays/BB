module BbInventoryHelpers
  module Cart
    # For this application, our cart is simply a hash consisting
    # of item_ids as keys and quantities as values.  The hash is 
    # saved as a session variable that the user should have  
    # available during the course of their interactions w/ system.

    def create_cart
      session[:cart] ||= Hash.new
    end

    def clear_cart
      session[:cart] = Hash.new
    end

    def destroy_cart
      session[:cart] = nil
    end

    def add_item_to_cart(item_id, qty=1)
      # if session[:cart].keys.include?(item_id.to_s)
      #   # if item in cart, set quantity to new value
      #   session[:cart][item_id.to_s] = qty
      # else
      #   # add it to the cart
      #   session[:cart][item_id.to_s] = qty
      # end
      session[:cart][item_id.to_s] = qty
    end

    def remove_item_from_cart(item_id)
      if session[:cart].keys.include?(item_id.to_s)
        session[:cart].delete(item_id.to_s)
      end
    end

    def get_list_of_items_in_cart
      # if no cart at this moment, call create_cart
      if session[:cart]==nil
        create_cart
      end
      
      bin_items = Array.new
      return bin_items if session[:cart].empty? # skip if cart empty...
      session[:cart].each do |item_id, quantity|
        info = {item_id: item_id, quantity: quantity}
        bin_item = BinItem.new(info)
        bin_items << bin_item
      end
      bin_items    
    end

    def save_each_item_in_cart(bin)
      session[:cart].each do |item_id, quantity|
        info = {item_id: item_id, quantity: quantity, bin_id: bin.id}
        # create Basket Items for each Basket
        b = BinItem.create(info)
      end

    end

  end
end
