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

ActiveRecord::Schema.define(version: 2018_10_25_180640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "slot"
    t.bigint "kit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_id"], name: "index_items_on_kit_id"
  end

  create_table "kit_lists", force: :cascade do |t|
    t.string "origin_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kits", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.bigint "kit_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_list_id"], name: "index_kits_on_kit_list_id"
  end

  add_foreign_key "items", "kits"
  add_foreign_key "kits", "kit_lists"
end
