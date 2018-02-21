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

ActiveRecord::Schema.define(version: 20180221110625) do

  create_table "contacts", force: :cascade do |t|
    t.string   "full_name",        limit: 255
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "given_name",       limit: 255
    t.string   "photo_url",        limit: 255
    t.string   "network_url",      limit: 255
    t.string   "network_username", limit: 255
    t.string   "gender",           limit: 255
    t.string   "email",            limit: 255
    t.string   "phone",            limit: 255
    t.date     "birthday"
    t.string   "hometown",         limit: 255
    t.string   "job_title",        limit: 255
    t.string   "organization",     limit: 255
    t.string   "industry",         limit: 255
    t.string   "country",          limit: 255
    t.text     "work"
    t.text     "education"
    t.string   "facebook_id",      limit: 255
    t.string   "google_id",        limit: 255
    t.string   "linkedin_id",      limit: 255
    t.string   "about",            limit: 255
    t.integer  "notes_id"
    t.boolean  "is_deleted",                   default: false
    t.integer  "user_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["identity_id"], name: "index_contacts_on_identity_id"
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

# Could not dump table "identities" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "notes", force: :cascade do |t|
    t.text     "note"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["contact_id"], name: "index_notes_on_contact_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
