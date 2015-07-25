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

ActiveRecord::Schema.define(version: 20150725044229) do

  create_table "participants", force: :cascade do |t|
    t.string  "full_name"
    t.string  "partner_full_name"
    t.integer "year_id"
  end

  add_index "participants", ["year_id"], name: "index_participants_on_year_id"

  create_table "secret_santa", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "year_id"
    t.string  "full_name"
  end

  add_index "secret_santa", ["participant_id"], name: "index_secret_santa_on_participant_id"
  add_index "secret_santa", ["year_id"], name: "index_secret_santa_on_year_id"

  create_table "years", force: :cascade do |t|
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
