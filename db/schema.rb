# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160423170833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
  end

  create_table "bin_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "bin_id"
    t.integer  "item_checkin_id"
    t.integer  "item_checkin_archive_id"
  end

  create_table "bins", force: :cascade do |t|
    t.date     "checkout_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "num_of_bins"
    t.integer  "agency_id"
    t.integer  "program_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_checkin_archives", force: :cascade do |t|
    t.integer  "quantity_checkedin"
    t.float    "unit_price"
    t.boolean  "donated"
    t.date     "checkin_date"
    t.integer  "item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "item_checkins", force: :cascade do |t|
    t.integer  "quantity_checkedin"
    t.integer  "quantity_remaining"
    t.float    "unit_price"
    t.boolean  "donated"
    t.date     "checkin_date"
    t.integer  "item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "barcode"
    t.string   "name"
    t.integer  "age",                      array: true
    t.text     "notes"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "gender"
  end

  add_index "items", ["age"], name: "index_items_on_age", using: :gin

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
