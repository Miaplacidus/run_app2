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

ActiveRecord::Schema.define(version: 20140929204105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: true do |t|
    t.string   "name"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "post_id"
    t.string   "state",        default: "pending"
    t.text     "notes",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["post_id"], name: "index_challenges_on_post_id", using: :btree
  add_index "challenges", ["recipient_id"], name: "index_challenges_on_recipient_id", using: :btree
  add_index "challenges", ["sender_id"], name: "index_challenges_on_sender_id", using: :btree

  create_table "circle_users", force: true do |t|
    t.integer  "circle_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circle_users", ["circle_id"], name: "index_circle_users_on_circle_id", using: :btree
  add_index "circle_users", ["user_id"], name: "index_circle_users_on_user_id", using: :btree

  create_table "circles", force: true do |t|
    t.string   "name"
    t.integer  "max_members"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "description"
    t.integer  "level"
    t.string   "city"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circles", ["admin_id"], name: "index_circles_on_admin_id", using: :btree

  create_table "commitments", force: true do |t|
    t.float    "amount"
    t.boolean  "fulfilled",  default: false
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commitments", ["post_id"], name: "index_commitments_on_post_id", using: :btree
  add_index "commitments", ["user_id"], name: "index_commitments_on_user_id", using: :btree

  create_table "join_requests", force: true do |t|
    t.integer  "circle_id"
    t.integer  "user_id"
    t.boolean  "accepted",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "join_requests", ["circle_id"], name: "index_join_requests_on_circle_id", using: :btree
  add_index "join_requests", ["user_id"], name: "index_join_requests_on_user_id", using: :btree

  create_table "post_users", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_users", ["post_id"], name: "index_post_users_on_post_id", using: :btree
  add_index "post_users", ["user_id"], name: "index_post_users_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "circle_id"
    t.integer  "creator_id"
    t.datetime "time"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "pace"
    t.text     "notes",        default: ""
    t.boolean  "complete"
    t.float    "min_amt"
    t.integer  "age_pref"
    t.integer  "gender_pref"
    t.integer  "max_runners"
    t.integer  "min_distance"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["circle_id"], name: "index_posts_on_circle_id", using: :btree
  add_index "posts", ["creator_id"], name: "index_posts_on_creator_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.integer  "gender"
    t.string   "email"
    t.string   "bday"
    t.float    "rating"
    t.string   "fbid"
    t.string   "img_url"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", force: true do |t|
    t.integer  "user_id"
    t.float    "balance",    default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", using: :btree

end
