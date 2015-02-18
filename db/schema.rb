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

ActiveRecord::Schema.define(version: 20140921145622) do

  create_table "dispatchers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flyers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "flyers", ["user_id"], name: "index_flyers_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "frequency"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "plan_id"
  end

  create_table "realtors", force: true do |t|
    t.string   "emai"
    t.string   "sic_code"
    t.string   "sic_code_description"
    t.string   "naics_code"
    t.string   "company_name"
    t.string   "contact_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "designations"
    t.string   "agency"
    t.string   "MSA"
    t.string   "license_type"
    t.string   "license_number"
    t.string   "license_issued"
    t.string   "license_expires"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.string   "company_website"
    t.string   "revenue"
    t.string   "employees"
    t.string   "affiliation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_pages", force: true do |t|
    t.string   "file_name"
    t.string   "display_name"
    t.string   "title_tag"
    t.text     "content_tag"
    t.boolean  "navigational"
    t.string   "layout_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_pages", ["file_name"], name: "index_static_pages_on_file_name", unique: true, using: :btree

  create_table "subscriptions", force: true do |t|
    t.string   "email"
    t.string   "stripe_customer_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree

  create_table "templates", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
