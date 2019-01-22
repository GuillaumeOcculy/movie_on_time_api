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

ActiveRecord::Schema.define(version: 2019_01_22_113926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chain_countries", force: :cascade do |t|
    t.bigint "chain_id"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chain_id"], name: "index_chain_countries_on_chain_id"
    t.index ["country_id"], name: "index_chain_countries_on_country_id"
  end

  create_table "chains", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cinemas", force: :cascade do |t|
    t.bigint "chain_id"
    t.bigint "country_id"
    t.string "external_id"
    t.string "name"
    t.string "phone"
    t.string "street"
    t.string "house"
    t.string "post_code"
    t.string "city"
    t.string "state"
    t.string "state_abbr"
    t.string "country_code"
    t.float "latitude"
    t.float "longitude"
    t.string "booking_type"
    t.string "website"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chain_id"], name: "index_cinemas_on_chain_id"
    t.index ["country_code"], name: "index_cinemas_on_country_code"
    t.index ["country_id"], name: "index_cinemas_on_country_id"
    t.index ["latitude", "longitude"], name: "index_cinemas_on_latitude_and_longitude"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "country_id"
    t.string "external_id"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso_code"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chain_countries", "chains"
  add_foreign_key "chain_countries", "countries"
  add_foreign_key "cinemas", "chains"
  add_foreign_key "cinemas", "countries"
  add_foreign_key "cities", "countries"
end
