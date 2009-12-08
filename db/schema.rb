# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091208163507) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "guild_id"
    t.integer  "user_id"
    t.string   "what"
    t.text     "description"
    t.datetime "when"
    t.string   "where"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["guild_id"], :name => "index_events_on_guild_id"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.integer  "guild_id"
    t.string   "permalink"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0
  end

  add_index "forums", ["guild_id"], :name => "index_forums_on_guild_id"

  create_table "guilds", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "game"
    t.string   "server"
    t.text     "about"
    t.string   "background_color",                     :default => "000000"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.string   "background_file_size"
    t.string   "background_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.string   "logo_file_size"
    t.string   "logo_updated_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "typ",                     :limit => 2, :default => 1
    t.text     "guild_join_text",                      :default => "Napisz pokrótce, dlaczego akurat chciałbyś dołączyć do naszej gildii/klanu?"
  end

  add_index "guilds", ["user_id"], :name => "index_guilds_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "guild_id"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
    t.string   "game_nick"
    t.string   "stats_link"
  end

  add_index "memberships", ["guild_id"], :name => "index_memberships_on_guild_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "moderatorships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "guild_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moderatorships", ["guild_id"], :name => "index_moderatorships_on_guild_id"
  add_index "moderatorships", ["user_id"], :name => "index_moderatorships_on_user_id"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "guild_id"
    t.integer  "duration",             :default => 0
    t.boolean  "processing",           :default => false
    t.string   "clip_file_name"
    t.string   "clip_content_type"
    t.integer  "clip_file_size"
    t.datetime "clip_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "preview_file_name"
    t.string   "preview_content_type"
    t.integer  "preview_file_size"
    t.datetime "preview_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["guild_id"], :name => "index_movies_on_guild_id"
  add_index "movies", ["user_id"], :name => "index_movies_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "guild_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["guild_id"], :name => "index_photos_on_guild_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "forum_id"
    t.boolean  "locked",        :default => false
    t.boolean  "sticky",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",   :default => 0
    t.integer  "replied_by_id"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["replied_by_id"], :name => "index_topics_on_replied_by_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",        :default => 0
    t.integer  "posts_count",         :default => 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "full_name"
    t.string   "www"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
