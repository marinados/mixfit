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

ActiveRecord::Schema.define(version: 2019_08_12_180237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_activities", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "vitamin_c_consumption"
    t.integer "vitamin_d3_consumption"
    t.integer "iron_consumption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_activities_on_user_id"
  end

  create_table "food_intakes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "vitamin_c"
    t.integer "vitamin_d3"
    t.integer "iron"
    t.index ["user_id"], name: "index_food_intakes_on_user_id"
  end

  create_table "personal_recipes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "vitamin_c_dosage"
    t.integer "vitamin_d3_dosage"
    t.integer "iron_dosage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_personal_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "height"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
  end

end
