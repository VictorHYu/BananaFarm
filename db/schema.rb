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

ActiveRecord::Schema.define(version: 20170913031035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bananas", id: :serial, force: :cascade do |t|
    t.integer "farm_banana_index", null: false
    t.integer "farm_id", null: false
    t.string "banana_name", null: false
    t.integer "count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tier", null: false
    t.string "stat_type", null: false
    t.integer "growth_stat", null: false
    t.integer "time_stat", null: false
    t.integer "value_stat", null: false
    t.string "weather_type", null: false
    t.boolean "is_special", null: false
  end

  create_table "farms", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "coins", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weather_temperature", default: 999, null: false
    t.string "weather_main", default: "none", null: false
    t.string "weather_icon", default: "01d.png", null: false
    t.datetime "weather_last_updated", default: "2000-01-01 01:01:01", null: false
  end

  add_foreign_key "bananas", "farms"
end
