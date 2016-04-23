require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # testing relationships
  should have_many(:items)

  # testing validations
  should validate_presence_of(:name)
  should validate_presence_of(:icon)
  should validate_uniqueness_of(:name)
  should validate_uniqueness_of(:icon)
end
