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
      # # if no cart at this moment, call create_cart
      # if session[:cart]==nil
      #   create_cart
      # end

      bin_items = Array.new
      return bin_items if session[:cart].empty? # skip if cart empty...

      session[:cart].each do |item_id, quantity|
        info={item_id: item_id, quantity: quantity}
        bin_items << info
      end

    end

    def save_each_item_in_cart(bin)
      session[:cart].each do |item_id, quantity|
        # get chronological list of item checkins for each item
        @item_checkins = ItemCheckin.checkins_for_item(item_id)

        quantity_required = quantity
        item_checkins_used = []
        bin_items_info = []
        # decrease remaining quantity
        for i in @item_checkins
          # if quantity required is checked out
          if quantity_required == 0
            break
          # if i has lower quantity than reqd qty
          elsif i.quantity_remaining < quantity_required
            info = {item_checkin_id: i.id, quantity: i.quantity_remaining, bin_id: bin_id}
            bin_items_info << info
            item_checkins_used << i 
            quantity_required-=i.quantity_remaining
          # if i has greater quantity than reqd qty
          elsif i.quantity_remaining > quantity_required
            info = {item_checkin_id: i.id, quantity: i.quantity_required, bin_id: bin_id}
            bin_items_info << info
            item_checkins_used << i
            quantity_required = 0
            break
          # if i has qty equal to reqd qty
          elsif i.quantity_remaining = quantity_required
            info = {item_checkin_id: i.id, quantity: i.quantity_remaining, bin_id: bin_id}
            bin_items_info << info
            item_checkins_used << i 
            quantity_required = 0
            break
          end
        end

        # set reqd qty to total qty
        quantity_required = quantity
        # create Bin Items for each Bin
        blen = bin_items_info.length - 1
        for i in blen
          info = bin_items_info[i]
          b = BinItem.create(info)

          # if reached end of array:
          if i == blen
            item_checkins_used[i].quantity_remaining-= quantity_required
          # else: 
          else
            item_checkins_used[i].quantity_remaining = 0
          end
          quantity_required -= item_checkins_used[i].quantity_remaining

        end

      end

    end

  end
end
