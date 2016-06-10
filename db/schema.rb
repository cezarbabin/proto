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

ActiveRecord::Schema.define(version: 20160610123827) do

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.text     "education"
    t.text     "expertise"
    t.text     "skills"
    t.text     "interests"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "prospects", force: :cascade do |t|
    t.string   "email"
    t.string   "pcode"
    t.integer  "actual_id",       default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "recommender_id"
    t.text     "description"
    t.boolean  "registered",      default: false
    t.datetime "registered_at"
    t.boolean  "pcode_is_valid",  default: true
    t.datetime "email_sent"
    t.text     "attributes_hash"
  end

  add_index "prospects", ["actual_id"], name: "index_prospects_on_actual_id"
  add_index "prospects", ["email"], name: "index_prospects_on_email"
  add_index "prospects", ["recommender_id"], name: "index_prospects_on_recommender_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "recommender_id"
    t.integer  "recommended_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "prospect",        default: false
    t.text     "description"
    t.text     "attributes_hash"
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
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "admin"
    t.integer  "post_id"
    t.datetime "post_created_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
