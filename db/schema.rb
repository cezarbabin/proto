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

ActiveRecord::Schema.define(version: 20160606205419) do

  create_table "prospects", force: :cascade do |t|
    t.string   "email"
    t.text     "description"
    t.string   "pcode"
    t.integer  "actual_id",      default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "recommender_id"
  end

  add_index "prospects", ["email"], name: "index_prospects_on_email", unique: true
  add_index "prospects", ["pcode"], name: "index_prospects_on_pcode", unique: true
  add_index "prospects", ["recommender_id"], name: "index_prospects_on_recommender_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "recommender_id"
    t.integer  "recommended_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "prospect",       default: false
  end

  add_index "relationships", ["recommended_id"], name: "index_relationships_on_recommended_id"
  add_index "relationships", ["recommender_id", "recommended_id"], name: "index_relationships_on_recommender_id_and_recommended_id", unique: true
  add_index "relationships", ["recommender_id"], name: "index_relationships_on_recommender_id"

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
