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

ActiveRecord::Schema.define(version: 20170502180503) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comedian_contact_submissions", force: :cascade do |t|
    t.string   "email"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "location_prompts", force: :cascade do |t|
    t.string   "address"
    t.text     "message"
    t.string   "cta_text"
    t.string   "cta_link"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "short_name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "performers", force: :cascade do |t|
    t.string   "name"
    t.string   "bio"
    t.string   "city"
    t.string   "country"
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "instagram_url"
    t.string   "youtube_url"
    t.string   "video_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "snapchat_url"
    t.string   "website_url"
    t.integer  "user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
    t.date     "date"
    t.time     "time"
    t.string   "rule"
    t.string   "interval"
    t.text     "day"
    t.text     "day_of_week"
    t.datetime "until"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_occurences", force: :cascade do |t|
    t.integer  "show_id"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "show_occurrences", force: :cascade do |t|
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "title"
    t.text     "about"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url_slug"
    t.boolean  "approved"
    t.string   "video_url"
    t.text     "video_description"
    t.text     "reason_we_recommend"
  end

  create_table "show_reviews", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "show_occurence_id"
    t.string   "title"
    t.text     "body"
    t.decimal  "rating"
    t.integer  "author_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
  end

  create_table "show_tag_entries", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "show_tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "is_active"
  end

  create_table "show_tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "front_page"
    t.string   "url_slug"
  end

  create_table "show_votes", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "show_occurrence_id"
    t.integer  "venue_id"
    t.boolean  "is_up"
    t.boolean  "is_down"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.string   "website_url"
    t.text     "about"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "start_time"
    t.integer  "user_id"
    t.integer  "producer_id"
    t.string   "url_slug"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state_province"
    t.string   "country"
    t.string   "venue_name"
    t.integer  "market_id"
    t.decimal  "price"
    t.integer  "category_1_id"
    t.integer  "category_2_id"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "time_zone"
    t.string   "address_street_address"
    t.string   "address_locality"
    t.string   "address_region"
    t.string   "address_country"
    t.string   "address_postal_code"
    t.boolean  "approved"
    t.text     "reason_we_recommend"
    t.string   "video_url"
    t.text     "video_description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "is_comic"
    t.boolean  "is_producer"
    t.boolean  "is_venue"
    t.integer  "performer_id"
    t.integer  "default_market_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "display_name"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: :cascade do |t|
    t.integer  "city_id"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "twitter_url"
    t.string   "instagram_url"
    t.string   "facebook_url"
    t.string   "youtube_url"
    t.string   "snapchat_url"
    t.string   "website_url"
    t.text     "about"
    t.string   "state_province"
    t.integer  "market_id"
    t.string   "city"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.string   "url_slug"
  end

end
