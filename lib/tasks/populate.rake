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
    require 'populator'

    # Step 1: Create Categories
    big_item = Category.new
    big_item.name = 'Big Item'
    big_item.icon = 'card_giftcard'
    big_item.save!

    small_item = Category.new
    small_item.name = 'Small Item'
    small_item.icon = 'donut_small'
    small_item.save!

    dental = Category.new
    dental.name = 'Dental Hygiene'
    dental.icon = 'brush'
    dental.save!

    reading_book = Category.new
    reading_book.name = 'Reading Book'
    reading_book.icon = 'book'
    reading_book.save!

    coloring_book = Category.new
    coloring_book.name = 'Coloring Book'
    coloring_book.icon = 'bookmark_border'
    coloring_book.save!

    crayon = Category.new
    crayon.name = 'Crayon'
    crayon.icon = 'folder_open'
    crayon.save!

    snack = Category.new
    snack.name = 'Snack'
    snack.icon = 'settings_input_composite'
    snack.save!

    # Step 2: Create Items
    category_ids = Category.all.to_a.map(&:id)
    Item.populate 1 do |item|
      # get some fake data using faker gem
      item.name = Faker::Name.name
      item.quantity = rand(100)
      item.age = [0,1]
      item.gender = rand(2)
      item.barcode = rand(10000..100000)
      item.donated = rand(1) == 1 ? true : false
      item.category_id = rand(category_ids)
      item.notes = Faker::Lorem.sentence
      # set the timestamps
      item.created_at = Time.now
      item.updated_at = Time.now   
    end

  end
end