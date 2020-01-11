class BetDetail < ApplicationRecord
  validates :transaction_id, presence: true, uniqueness: true
  validates :version_key, presence: true, uniqueness: true
  before_save :adjust_date_time

  def adjust_date_time
    self.match_datetime = DateTime.parse(self.match_datetime.to_s) + (4 / 24.0) unless self.match_datetime.nil?
    self.transaction_time = DateTime.parse(self.transaction_time.to_s) + (4 / 24.0) unless self.transaction_time.nil?
    self.winlost_datetime = DateTime.parse(self.winlost_datetime.to_s) + (4 / 24.0) unless self.winlost_datetime.nil?
    self.settlement_time = DateTime.parse(self.settlement_time.to_s) + (4 / 24.0) unless self.settlement_time.nil?
  end
end