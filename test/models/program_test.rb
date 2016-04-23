require 'test_helper'

class ProgramTest < ActiveSupport::TestCase
  # testing relationships
  should have_many(:bins)

  # testing validations
  should validate_uniqueness_of(:name)
end
