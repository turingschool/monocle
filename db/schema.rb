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

ActiveRecord::Schema.define(version: 20161130215611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "categories", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
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
    t.citext   "phone"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "zip_code_id"
    t.index ["category_id"], name: "index_companies_on_category_id", using: :btree
    t.index ["city_id"], name: "index_companies_on_city_id", using: :btree
    t.index ["state_id"], name: "index_companies_on_state_id", using: :btree
    t.index ["zip_code_id"], name: "index_companies_on_zip_code_id", using: :btree
  end

  create_table "starred_companies", id: false, force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "slack_uid"
    t.text     "slack_access_token"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "role"
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "categories"
  add_foreign_key "companies", "cities"
  add_foreign_key "companies", "states"
  add_foreign_key "companies", "zip_codes"
end
