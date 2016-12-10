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

ActiveRecord::Schema.define(version: 20161208010246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "cities", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.citext   "name"
    t.citext   "website"
    t.citext   "headquarters"
    t.citext   "products_services"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "status"
    t.citext   "size"
    t.string   "logo"
  end

  create_table "company_industries", force: :cascade do |t|
    t.integer "company_id"
    t.integer "industry_id"
    t.index ["company_id"], name: "index_company_industries_on_company_id", using: :btree
    t.index ["industry_id"], name: "index_company_industries_on_industry_id", using: :btree
  end

  create_table "industries", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string  "street_address"
    t.string  "street_address_2"
    t.string  "phone"
    t.string  "primary_contact"
    t.integer "status"
    t.integer "company_id"
    t.string  "zip_code"
    t.citext  "city"
    t.string  "state"
    t.index ["company_id"], name: "index_locations_on_company_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_notes_on_company_id", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
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

  add_foreign_key "company_industries", "companies"
  add_foreign_key "company_industries", "industries"
  add_foreign_key "locations", "companies"
  add_foreign_key "notes", "companies"
  add_foreign_key "notes", "users"
end
