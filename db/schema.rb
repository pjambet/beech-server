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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130418030325) do

  create_table "awards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "awards", ["user_id", "badge_id"], :name => "index_awards_on_user_id_and_badge_id"

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "badge_type"
    t.text     "condition"
    t.integer  "quantity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "description_fr"
    t.string   "photo"
    t.boolean  "published"
    t.text     "description_en"
  end

  create_table "beer_colors", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "beer_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "beers", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.integer  "beer_color_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "accepted"
    t.integer  "added_by_id"
    t.integer  "color_pattern"
  end

  add_index "beers", ["added_by_id"], :name => "index_beers_on_added_by_id"
  add_index "beers", ["beer_color_id"], :name => "index_beers_on_beer_color_id"

  create_table "checks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "beer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "checks", ["user_id", "beer_id"], :name => "index_checks_on_user_id_and_beer_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["user_id", "event_id"], :name => "index_comments_on_user_id_and_event_id"

  create_table "events", :force => true do |t|
    t.integer  "eventable_id"
    t.integer  "user_id"
    t.string   "eventable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "events", ["eventable_id"], :name => "index_events_on_eventable_id"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followings", ["follower_id", "followee_id"], :name => "index_followings_on_follower_id_and_followee_id"

  create_table "likes", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  add_index "memberships", ["role_id", "user_id"], :name => "index_memberships_on_role_id_and_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nickname"], :name => "index_users_on_nickname"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
