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

ActiveRecord::Schema.define(version: 20150202174239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: true do |t|
    t.string   "code"
    t.datetime "expiration_date"
    t.integer  "trip_id"
  end

  create_table "destinations", force: true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "full_qualified_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
  end

  create_table "recommendation_types", force: true do |t|
    t.boolean "hotels"
    t.boolean "attractions"
    t.boolean "restaurants"
  end

  create_table "recommendations", force: true do |t|
    t.integer  "recommender_id"
    t.integer  "place_id"
    t.integer  "trip_id"
    t.string   "description"
    t.boolean  "wishlisted"
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place_type"
    t.string   "google_places_url"
  end

  create_table "recommenders", force: true do |t|
    t.integer "user_id"
    t.integer "trip_id"
    t.integer "code_id"
  end

  create_table "trips", force: true do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "destination_id"
    t.integer  "user_id"
    t.integer  "recommendation_type_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "fb_id"
    t.string   "fb_token",        limit: 256
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_picture"
  end

end
