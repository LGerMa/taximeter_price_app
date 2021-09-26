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

ActiveRecord::Schema.define(version: 2021_09_26_053530) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taximeters", force: :cascade do |t|
    t.decimal "start_price", precision: 6, scale: 2
    t.decimal "km_price", precision: 6, scale: 2
    t.decimal "minute_price", precision: 6, scale: 2
    t.decimal "minimum_price", precision: 6, scale: 2
    t.time "time_from"
    t.time "time_to"
    t.string "days"
    t.integer "company_id", null: false
    t.integer "time_from_minutes"
    t.integer "time_to_minutes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_taximeters_on_company_id"
  end

  add_foreign_key "taximeters", "companies"
end
