# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_19_014610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.bigint "user_id", null: false
    t.string "category"
    t.boolean "custom_string1_state"
    t.string "custom_string1_name"
    t.boolean "custom_string2_state"
    t.string "custom_string2_name"
    t.boolean "custom_string3_state"
    t.string "custom_string3_name"
    t.boolean "custom_int1_state"
    t.string "custom_int1_name"
    t.boolean "custom_int2_state"
    t.string "custom_int2_name"
    t.boolean "custom_int3_state"
    t.string "custom_int3_name"
    t.boolean "custom_text1_state"
    t.string "custom_text1_name"
    t.boolean "custom_text2_state"
    t.string "custom_text2_name"
    t.boolean "custom_text3_state"
    t.string "custom_text3_name"
    t.boolean "custom_bool1_state"
    t.string "custom_bool1_name"
    t.boolean "custom_bool2_state"
    t.boolean "custom_bool2_name"
    t.boolean "custom_bool3_state"
    t.boolean "custom_bool3_name"
    t.boolean "custom_date1_state"
    t.string "custom_date1_name"
    t.boolean "custom_date2_state"
    t.string "custom_date2_name"
    t.boolean "custom_date3_state"
    t.string "custom_date3_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "tags"
    t.bigint "collection_id", null: false
    t.string "custom_string1_value"
    t.string "custom_string2_value"
    t.string "custom_string3_value"
    t.integer "custom_int1_value"
    t.integer "custom_int2_value"
    t.integer "custom_int3_value"
    t.text "custom_text1_value"
    t.text "custom_text2_value"
    t.text "custom_text3_value"
    t.boolean "custom_bool1_value"
    t.boolean "custom_bool2_value"
    t.boolean "custom_bool3_value"
    t.date "custom_date1_value"
    t.date "custom_date2_value"
    t.date "custom_date3_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_items_on_collection_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "name"
    t.boolean "blocked", default: false
    t.integer "sign_in_count", default: 0, null: false
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "theme"
    t.string "language"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "collections", "users"
  add_foreign_key "items", "collections"
end
