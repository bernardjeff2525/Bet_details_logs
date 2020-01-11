class CreateBetDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :bet_details do |t|
      t.integer :transaction_id, limit: 8, unique: true
      t.string :vendor_member_id
      t.string :operator_id
      t.integer :league_id
      t.integer :match_id
      t.integer :home_id
      t.integer :away_id
      t.datetime :match_datetime
      t.integer :sport_type
      t.integer :bet_type
      t.integer :parlay_ref_no
      t.decimal :odds
      t.decimal :stake
      t.datetime :transaction_time
      t.string :ticket_status
      t.decimal :win_lost_amount
      t.decimal :after_amount
      t.integer :currency
      t.datetime :winlost_datetime
      t.integer :odds_type
      t.string :bet_team
      t.string :is_lucky
      t.decimal :home_hdp
      t.decimal :away_hdp
      t.decimal :hdp
      t.string :bet_from
      t.string :is_live
      t.integer :home_score
      t.integer :away_score
      t.datetime :settlement_time
      t.string :custom_info1
      t.string :custom_info2
      t.string :custom_info3
      t.string :custom_info4
      t.string :custom_info5
      t.string :ba_status
      t.integer :version_key, index: true, unique: true
    end
  end
end
