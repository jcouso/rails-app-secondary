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

ActiveRecord::Schema.define(version: 20170823190137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "security_id"
    t.boolean  "status",      default: false
    t.decimal  "price"
    t.decimal  "rate"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "indexer"
    t.index ["buyer_id"], name: "index_bids_on_buyer_id", using: :btree
    t.index ["security_id"], name: "index_bids_on_security_id", using: :btree
    t.index ["seller_id"], name: "index_bids_on_seller_id", using: :btree
  end

  create_table "issuers", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "securities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "issuer_id"
    t.integer  "security_type_id"
    t.string   "mode"
    t.string   "name"
    t.string   "code"
    t.date     "maturity"
    t.decimal  "price"
    t.date     "date_limit"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "quantity"
    t.decimal  "rate"
    t.decimal  "unit_price"
    t.string   "indexer"
    t.date     "issue_date"
    t.string   "file"
    t.index ["issuer_id"], name: "index_securities_on_issuer_id", using: :btree
    t.index ["security_type_id"], name: "index_securities_on_security_type_id", using: :btree
    t.index ["user_id"], name: "index_securities_on_user_id", using: :btree
  end

  create_table "security_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "name"
    t.string   "cpf"
    t.string   "document_number"
    t.date     "birthdate"
    t.string   "mother_name"
    t.string   "father_name"
    t.string   "address"
    t.string   "phone"
    t.string   "bank"
    t.string   "account_agency"
    t.string   "account_number"
    t.date     "expedition_date"
    t.float    "balance",                default: 0.0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bids", "securities"
  add_foreign_key "bids", "users", column: "buyer_id"
  add_foreign_key "bids", "users", column: "seller_id"
  add_foreign_key "securities", "issuers"
  add_foreign_key "securities", "security_types"
  add_foreign_key "securities", "users"
end
