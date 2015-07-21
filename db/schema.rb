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

ActiveRecord::Schema.define(version: 20150721004356) do

  create_table "board_categories", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.text     "name"
    t.text     "board_link"
    t.datetime "created_at"
    t.integer  "posts"
    t.integer  "followers"
    t.text     "latest_post"
    t.datetime "updated_at"
    t.integer  "board_category_id"
    t.datetime "last_post"
  end

  create_table "logics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "board_id"
    t.integer  "user_id"
    t.string   "post_link"
    t.text     "post_date"
    t.string   "post_title"
    t.integer  "message_id",  limit: 8
    t.integer  "post_number"
    t.text     "post_body",   limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_by_day_records", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tablerows", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "name"
    t.text     "profile_link"
    t.integer  "followed_by",      limit: 8
    t.integer  "posts",            limit: 8
    t.integer  "boards_moderated", limit: 8
    t.datetime "alias_born"
    t.integer  "user_id",          limit: 8
  end

  create_table "word_to_posts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "word_id"
    t.integer  "user_id"
    t.integer  "source_type"
  end

  create_table "words", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
  end

end
