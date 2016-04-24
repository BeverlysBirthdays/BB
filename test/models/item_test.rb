require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # testing relationships
  should belong_to(:category)
  #should have_many(:bin_items) #### fails
  should have_many(:item_checkins)
  should have_many(:item_checkin_archives)

  # testing validations
  should validate_presence_of(:name)
  should validate_presence_of(:category_id)
  should validate_presence_of(:age)

  should validate_inclusion_of(:gender).in_array(Item::GENDER_LIST.to_h.values)

end
