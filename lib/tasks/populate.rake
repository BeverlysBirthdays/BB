namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate
    Rake::Task['db:migrate'].invoke

    require 'faker'

    # Step 1: Create Categories
    big_item = Category.new
    big_item.name = 'Big Item'
    big_item.icon = 'BI'
    big_item.save!

    small_item = Category.new
    small_item.name = 'Small Item'
    small_item.icon = 'SI'
    small_item.save!

    dental = Category.new
    dental.name = 'Dental Hygiene'
    dental.icon = 'DH'
    dental.save!

    reading_book = Category.new
    reading_book.name = 'Reading Book'
    reading_book.icon = 'RB'
    reading_book.save!

    coloring_book = Category.new
    coloring_book.name = 'Coloring Book'
    coloring_book.icon = 'CB'
    coloring_book.save!

    crayon = Category.new
    crayon.name = 'Crayon'
    crayon.icon = 'C'
    crayon.save!

    snack = Category.new
    snack.name = 'Snack'
    snack.icon = 'S'
    snack.save!

    # Step 2: Create Items
    category_ids = Category.all.to_a.map(&:id)
    # Item.populate 1 do |item|
    200.times do 
      item = Item.new
      # get some fake data using faker gem
      item.name = Faker::Commerce.product_name
      item.age = [[0,1],[1,2],[0,1,2],[0],[0],[1],[1],[2]].sample
      item.gender = rand(2)
      item.barcode = (10000..100000).to_a.sample
      item.category_id = category_ids.sample
      item.notes = Faker::Lorem.sentence
      # temporary attributes
      item.donated = true
      item.unit_price = 1.5
      item.check_in_quantity = 1
      # set the timestamps
      item.save!   
    end

  end
end