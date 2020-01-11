class ParlayDataRecord < ApplicationRecord
  belongs_to :bet_detail
  validates :parlay_id, presence: true , uniqueness: true
  before_save :adjust_date_time

  def adjust_date_time
    self.match_datetime = DateTime.parse(self.match_datetime.to_s) + (4 / 24.0) unless self.match_datetime.nil?
    self.winlost_datetime = DateTime.parse(self.winlost_datetime.to_s) + (4 / 24.0) unless self.winlost_datetime.nil?
  end
end