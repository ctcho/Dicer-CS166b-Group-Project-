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

ActiveRecord::Schema.define(version: 20170329191543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_rooms_users", force: :cascade do |t|
    t.integer  "chat_room_id"
    t.integer  "user_id"
    t.datetime "last_viewed"
  end

  create_table "dm_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bio"
    t.integer  "experience_level"
    t.integer  "online_play"
    t.integer  "homebrew"
    t.integer  "original_ruleset"
    t.integer  "advanced_ruleset"
    t.integer  "pathfinder"
    t.integer  "third"
    t.integer  "three_point_five"
    t.integer  "fourth"
    t.integer  "fifth"
    t.integer  "original_campaign"
    t.integer  "module"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.string   "image_path"
    t.integer  "user_id"
    t.integer  "chat_room_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "player_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "bio"
    t.integer  "experience_level"
    t.integer  "online_play"
    t.integer  "homebrew"
    t.integer  "original_ruleset"
    t.integer  "advanced_ruleset"
    t.integer  "pathfinder"
    t.integer  "third"
    t.integer  "three_point_five"
    t.integer  "fourth"
    t.integer  "fifth"
    t.integer  "original_campaign"
    t.integer  "module"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.float    "lat"
    t.float    "lng"
    t.string   "remember_digest"
    t.float    "max_distance"
    t.integer  "age"
    t.string   "address"
    t.datetime "last_active"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",               default: false
  end

end
