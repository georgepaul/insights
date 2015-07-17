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

ActiveRecord::Schema.define(version: 20150712170314) do

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
    t.datetime "posts"
    t.datetime "followers"
    t.datetime "updated_at"
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
    t.text     "post_body"
    t.integer  "post_number"
    t.string   "post_title"
    t.datetime "post_date"
    t.string   "post_link"
    t.integer  "user_id"
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
    t.string   "name"
    t.string   "profile_link"
    t.integer  "followed_by"
    t.integer  "posts"
    t.integer  "boards_moderated"
    t.datetime "alias_born"
    t.integer  "user_id"
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
