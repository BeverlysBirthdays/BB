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

        if @item_checkins.nil?
          errors.add(@item, 'not in stock')
          return # skip rest if not in stock
        end
        decrease_inventory_quantity(bin, quantity, @item_checkins)
      end
    end

    # decrease quantity in item_checkin after saving each item in cart
    def decrease_inventory_quantity(bin, quantity, item_checkins)

      # total quantity required from different item checkins
      quantity_required = quantity
      item_checkins_used = [] # add to this to decrease quantity in inventory
      bin_items_info = [] # add to this array to create BinItems
      # decrease remaining quantity
      for i in item_checkins
        # if quantity required is checked out
        if quantity_required == 0
          break
        # if i has lower quantity than reqd qty
        elsif i.quantity_remaining < quantity_required
          info = {item_checkin_id: i.id, quantity: i.quantity_remaining}
          bin_items_info << info
          item_checkins_used << i 
          quantity_required-=i.quantity_remaining
        # if i has greater quantity than reqd qty
        elsif i.quantity_remaining > quantity_required
          info = {item_checkin_id: i.id, quantity: quantity_required}
          bin_items_info << info
          item_checkins_used << i
          quantity_required = 0
          break
        # if i has qty equal to reqd qty
        elsif i.quantity_remaining == quantity_required
          info = {item_checkin_id: i.id, quantity: i.quantity_remaining}
          bin_items_info << info
          item_checkins_used << i 
          quantity_required = 0
          break
        end
      end

      # set reqd qty to total qty
      quantity_required = quantity
      # create Bin Items for each Bin
      blen = bin_items_info.length
      blen.times do |i|
        info = bin_items_info[i]
        b = BinItem.create(info)
        b.bin_id = bin.id
        b.save!


        # if reached end of array:
        if i == blen-1
          item_checkins_used[i].quantity_remaining-= quantity_required
        # else: 
        else
          item_checkins_used[i].quantity_remaining = 0
        end
        # save changes in quantity
        item_checkins_used[i].save!
        quantity_required -= item_checkins_used[i].quantity_remaining

        # trigger: move item_checkin to archive if quantity_remaining = 0
        if item_checkins_used[i].quantity_remaining==0
          move_item_checkin_to_archive(b,item_checkins_used[i])
        end

      end

    end

    def move_item_checkin_to_archive(bin_item, item_checkin)
      info = {quantity_checkedin: item_checkin.quantity_checkedin, unit_price: item_checkin.unit_price, donated: item_checkin.donated, checkin_date: item_checkin.checkin_date, item_id: item_checkin.item_id}
      i = ItemCheckinArchive.create(info)

      # ensure item in archive created:
      if !i.nil?
        # delete item_checkin
        item_checkin.destroy 
        # update bin_item with archive_id
        update_bin_item_with_archive_id(bin_item, i.id)

      end

    end

    def update_bin_item_with_archive_id(bin_item, item_checkin_archive_id)
      bin_item.item_checkin_id = nil
      bin_item.item_checkin_archive_id = item_checkin_archive_id
      bin_item.save!
    end

  # end of both modules
  end
end
