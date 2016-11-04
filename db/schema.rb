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

ActiveRecord::Schema.define(version: 20161103175718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "categories", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "category_id"
    t.citext   "name"
    t.citext   "street_address"
    t.citext   "city_state_zip"
    t.citext   "website"
    t.citext   "headquarters"
    t.citext   "products_services"
    t.citext   "person_in_charge"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["category_id"], name: "index_companies_on_category_id", using: :btree
  end

  add_foreign_key "companies", "categories"
end
