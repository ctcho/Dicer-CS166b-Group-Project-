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

ActiveRecord::Schema.define(version: 20170222185448) do

  create_table "character_sheets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "filename"
    t.text     "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dm_profiles", force: :cascade do |t|
    t.text     "bio"
    t.integer  "exp_level"
    t.boolean  "ruleset1"
    t.boolean  "ruleset2"
    t.boolean  "ruleset3"
    t.boolean  "ruleset4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "player_profiles", force: :cascade do |t|
    t.text     "bio"
    t.string   "exp_level"
    t.boolean  "ruleset1"
    t.boolean  "ruleset2"
    t.boolean  "ruleset3"
    t.boolean  "ruleset4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "username"
    t.integer  "zipcode"
    t.string   "profile_pic"
    t.integer  "player_id"
    t.integer  "dm_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
