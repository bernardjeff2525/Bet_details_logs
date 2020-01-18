class CreateBalanceHistoryRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_history_records do |t|
      t.string :vendor_member_id
      t.string :type
      t.decimal :balance
      t.integer :currency_id
      t.decimal :amount
      t.string :vendor_trans_id
    end
  end
end
