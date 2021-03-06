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

ActiveRecord::Schema.define(version: 2018_11_02_200655) do

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

  create_table "kit_list_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "kit_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_list_id"], name: "index_kit_list_users_on_kit_list_id"
    t.index ["user_id", "kit_list_id"], name: "index_kit_list_users_on_user_id_and_kit_list_id", unique: true
    t.index ["user_id"], name: "index_kit_list_users_on_user_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "kits"
  add_foreign_key "kits", "kit_lists"
end
