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

ActiveRecord::Schema.define(version: 20151013204058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "age"
    t.string   "description"
    t.boolean  "dog_friendly"
    t.boolean  "cat_friendly"
    t.integer  "animal_rescue_id",                 null: false
    t.integer  "fostered_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "animal_photo"
    t.string   "shelter_id"
    t.string   "animal",           default: "Dog", null: false
    t.string   "sex",                              null: false
    t.string   "photo"
    t.string   "status"
  end

  create_table "foster_offers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "animal_id"
    t.integer  "animal_rescue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: :cascade do |t|
    t.boolean "dog_friendly"
    t.boolean "cat_friendly"
    t.boolean "kid_friendly"
    t.string  "city"
    t.string  "state"
    t.boolean "rescue_group", default: false
    t.string  "name"
    t.string  "email"
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                                null: false
    t.string   "city",                                null: false
    t.string   "state",                               null: false
    t.string   "phone"
    t.string   "description"
    t.boolean  "rescue_group"
    t.string   "profile_photo"
    t.boolean  "has_dogs"
    t.boolean  "has_cats"
    t.boolean  "has_kids"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
