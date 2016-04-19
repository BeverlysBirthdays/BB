module BbInventoryHelpers
  module Trigger

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
        move_item_checkin_to_archive(b,item_checkins_used[i])

      end

    end

    def move_item_checkin_to_archive(bin_item, item_checkin)
      info = {quantity_checkedin: item_checkin.quantity_checkedin, unit_price: item_checkin.unit_price, donated: item_checkin.donated, checkin_date: item_checkin.checkin_date, item_id: item_checkin.item_id}
      i = ItemCheckinArchive.create(info)

      # update bin item with archive_id
      update_bin_item_with_arhive_id(bin_item, i.id)
      
    end

    def update_bin_item_with_archive_id(bin_item, item_checkin_archive_id)
      bin_item.item_checkin_id = nil
      bin_item.item_checkin_archive_id = item_checkin_archive_id
      bin_item.save!
    end

# end of both modules
  end
end