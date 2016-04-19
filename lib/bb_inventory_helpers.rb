# require needed files
require 'helpers/cart'
require 'helpers/trigger'

# create BreadExpressHelpers
module BbInventoryHelpers
  include BbInventoryHelpers::Cart
  include BbInventoryHelpers::Trigger
end