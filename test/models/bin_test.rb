require 'test_helper'

class BinTest < ActiveSupport::TestCase
  # testing relationships
  should belong_to(:program)
  should have_many(:bin_items)
  # should have_many(:items).through(:bin_items)
  should belong_to(:agency)

  # testing validations
  should validate_numericality_of(:num_of_bins)
  should allow_value(1).for(:num_of_bins)
  should_not allow_value(0).for(:num_of_bins)
  should_not allow_value(2.22).for(:num_of_bins)
  should_not allow_value("bad").for(:num_of_bins)

  should allow_value(Date.today).for(:checkout_date)
  should_not allow_value("bad").for(:checkout_date)
end
