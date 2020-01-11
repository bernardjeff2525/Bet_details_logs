class CreateParlayDataRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :parlay_data_records do |t|
      t.integer :parlay_id ,limit: 8 ,unique: true
      t.integer :bet_detail_id
      t.integer :league_id
      t.integer :match_id
      t.integer :home_id
      t.integer :away_id
      t.datetime :match_datetime
      t.decimal :odds
      t.integer :bet_type
      t.integer :bet_team
      t.integer :sport_type
      t.decimal :home_hdp
      t.decimal :away_hdp
      t.decimal :hdp
      t.string :is_live
      t.integer :home_score
      t.integer :away_score
      t.string :ticket_status
      t.datetime :winlost_datetime
    end
  end
end
