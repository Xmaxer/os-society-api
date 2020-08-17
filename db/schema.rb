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

ActiveRecord::Schema.define(version: 2020_08_15_145840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competition_records", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "xp", null: false
    t.integer "position", null: false
    t.bigint "competition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["competition_id"], name: "index_competition_records_on_competition_id"
    t.index ["player_id"], name: "index_competition_records_on_player_id"
    t.index ["position", "competition_id"], name: "index_competition_records_on_position_and_competition_id", unique: true
  end

  create_table "competitions", force: :cascade do |t|
    t.string "external_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payouts", force: :cascade do |t|
    t.bigint "paid_by_id", null: false
    t.integer "amount", null: false
    t.bigint "competition_record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["competition_record_id"], name: "index_payouts_on_competition_record_id"
    t.index ["paid_by_id"], name: "index_payouts_on_paid_by_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username", limit: 20, null: false
    t.datetime "join_date"
    t.integer "rank", null: false
    t.boolean "removed", null: false
    t.string "previous_names", default: [], null: false, array: true
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_players_on_username", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 20, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "secret_key", null: false
    t.boolean "reset_password", default: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "competition_records", "competitions"
  add_foreign_key "competition_records", "players"
  add_foreign_key "payouts", "competition_records"
  add_foreign_key "payouts", "users", column: "paid_by_id"
end
