require 'test_helper'

class BinItemTest < ActiveSupport::TestCase
  # testing relationships
  should belong_to(:bin)
  should belong_to(:item_checkin)
  should belong_to(:item_checkin_archive)

  # testing validations
  should validate_numericality_of(:quantity)
  should allow_value(5).for(:quantity)
  should_not allow_value(0).for(:quantity)
  should_not allow_value(-3).for(:quantity)
  should_not allow_value(3.14159).for(:quantity)
  should_not allow_value("bad").for(:quantity)
end
