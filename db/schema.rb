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

ActiveRecord::Schema.define(version: 2020_05_08_140748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.string "media_type"
    t.bigint "media_id"
    t.bigint "content_id"
    t.boolean "purchasable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_contents_on_content_id"
    t.index ["media_type", "media_id"], name: "index_contents_on_media_type_and_media_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "title"
    t.text "plot"
    t.integer "index"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "plot"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.integer "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_purchases_on_content_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title"
    t.text "plot"
    t.integer "index"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "contents", "contents"
  add_foreign_key "purchases", "contents"
  add_foreign_key "purchases", "users"
end
