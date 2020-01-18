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

ActiveRecord::Schema.define(version: 2020_01_14_081315) do

  create_table "balance_history_records", force: :cascade do |t|
    t.string "vendor_member_id"
    t.string "type"
    t.decimal "balance"
    t.integer "currency_id"
    t.decimal "amount"
    t.string "vendor_trans_id"
  end

  create_table "bet_details", force: :cascade do |t|
    t.integer "transaction_id", limit: 8
    t.string "vendor_member_id"
    t.string "operator_id"
    t.integer "league_id"
    t.integer "match_id"
    t.integer "home_id"
    t.integer "away_id"
    t.datetime "match_datetime"
    t.integer "sport_type"
    t.integer "bet_type"
    t.integer "parlay_ref_no"
    t.decimal "odds"
    t.decimal "stake"
    t.datetime "transaction_time"
    t.string "ticket_status"
    t.decimal "win_lost_amount"
    t.decimal "after_amount"
    t.integer "currency"
    t.datetime "winlost_datetime"
    t.integer "odds_type"
    t.string "bet_team"
    t.string "is_lucky"
    t.decimal "home_hdp"
    t.decimal "away_hdp"
    t.decimal "hdp"
    t.string "bet_from"
    t.string "is_live"
    t.integer "home_score"
    t.integer "away_score"
    t.datetime "settlement_time"
    t.string "custom_info1"
    t.string "custom_info2"
    t.string "custom_info3"
    t.string "custom_info4"
    t.string "custom_info5"
    t.string "ba_status"
    t.integer "version_key"
    t.index ["version_key"], name: "index_bet_details_on_version_key"
  end

  create_table "parlay_data_records", force: :cascade do |t|
    t.integer "parlay_id", limit: 8
    t.integer "bet_detail_id"
    t.integer "league_id"
    t.integer "match_id"
    t.integer "home_id"
    t.integer "away_id"
    t.datetime "match_datetime"
    t.decimal "odds"
    t.integer "bet_type"
    t.integer "bet_team"
    t.integer "sport_type"
    t.decimal "home_hdp"
    t.decimal "away_hdp"
    t.decimal "hdp"
    t.string "is_live"
    t.integer "home_score"
    t.integer "away_score"
    t.string "ticket_status"
    t.datetime "winlost_datetime"
  end

end
