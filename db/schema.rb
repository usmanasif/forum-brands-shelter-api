# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_01_003911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age", null: false
    t.string "breed", null: false
    t.decimal "weight", null: false
    t.integer "animal_type", null: false
    t.datetime "joined_at", null: false
    t.datetime "adopted_at"
    t.boolean "adopted", default: false
    t.bigint "shelter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "guardian_id"
    t.index ["guardian_id"], name: "index_animals_on_guardian_id"
    t.index ["shelter_id"], name: "index_animals_on_shelter_id"
  end

  create_table "guardians", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.string "address", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shelters", force: :cascade do |t|
    t.string "country", null: false
    t.string "city", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "animals", "guardians"
end
