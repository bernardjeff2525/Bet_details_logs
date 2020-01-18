class SabaBetDetailsService
  attr_reader :vendor_id
  attr_reader :wallet_id
  attr_reader :version_key
  attr_reader :bet_details
  attr_reader :error_code
  attr_reader :error_message
  attr_reader :errors

  def initialize(version_key)
    @vendor_id = Rails.application.config_for(:api_data)['saba']['vendor_id']
    @wallet_id = Rails.application.config_for(:api_data)['saba']['wallet_id']
    @version_key = version_key
    request_bet_details
    remove_exists_transaction_id
    validate_errors
    save_bet_details
  end

  def save_bet_details
    return if bet_details.size == 0 || errors.any?
    bet_details.each do |bet_detail|
      bet_record = BetDetail.new(transaction_id: bet_detail['trans_id'],
                                 vendor_member_id: bet_detail['vendor_member_id'],
                                 operator_id: bet_detail['operator_id'],
                                 league_id: bet_detail['league_id'],
                                 match_id: bet_detail['match_id'],
                                 home_id: bet_detail['home_id'],
                                 away_id: bet_detail['away_id'],
                                 match_datetime: bet_detail['match_datetime'],
                                 sport_type: bet_detail['sport_type'],
                                 bet_type: bet_detail['bet_type'],
                                 parlay_ref_no: bet_detail['parlay_ref_no'],
                                 odds: bet_detail['odds'],
                                 stake: bet_detail['stake'],
                                 transaction_time: bet_detail['transaction_time'],
                                 ticket_status: bet_detail['ticket_status'],
                                 win_lost_amount: bet_detail['winlost_amount'],
                                 after_amount: bet_detail['after_amount'],
                                 currency: bet_detail['currency'],
                                 winlost_datetime: bet_detail['winlost_datetime'],
                                 odds_type: bet_detail['odds_type'],
                                 bet_team: bet_detail['bet_team'],
                                 is_lucky: bet_detail['isLucky'],
                                 home_hdp: bet_detail['home_hdp'],
                                 away_hdp: bet_detail['away_hdp'],
                                 hdp: bet_detail['hdp'],
                                 bet_from: bet_detail['betfrom'],
                                 is_live: bet_detail['islive'],
                                 home_score: bet_detail['home_score'],
                                 away_score: bet_detail['away_score'],
                                 settlement_time: bet_detail['settlement_time'] ,
                                 custom_info1: bet_detail['customInfo1'],
                                 custom_info2: bet_detail['customInfo2'],
                                 custom_info3: bet_detail['customInfo3'],
                                 custom_info4: bet_detail['customInfo4'],
                                 custom_info5: bet_detail['customInfo5'],
                                 ba_status: bet_detail['ba_status'],
                                 version_key: bet_detail['version_key'])
      bet_record.save
      next if bet_detail['ParlayData'].nil?
      bet_detail['ParlayData'].each do |parlay_data|
        parlay_data_record = ParlayDataRecord.new(
            parlay_id: parlay_data['parlay_id'],
            bet_detail: bet_record,
            league_id: parlay_data['league_id'],
            match_id: parlay_data['match_id'],
            home_id: parlay_data['home_id'],
            away_id: parlay_data['away_id'],
            match_datetime: parlay_data['match_datetime'],
            odds: parlay_data['odds'],
            bet_type: parlay_data['bet_type'],
            bet_team: parlay_data['bet_team'],
            sport_type: parlay_data['sport_type'],
            home_hdp: parlay_data['home_hdp'],
            away_hdp: parlay_data['away_hdp'],
            hdp: parlay_data['hdp'],
            is_live: parlay_data['islive'],
            home_score: parlay_data['home_score'],
            away_score: parlay_data['away_score'],
            ticket_status: parlay_data['ticket_status'],
            winlost_datetime: parlay_data['winlost_datetime'])
        parlay_data_record.save
      end
    end
  end

  def remove_exists_transaction_id
    transaction_ids = BetDetail.pluck(:transaction_id)
    @bet_details.reject! {|bet_detail| transaction_ids.include? bet_detail['trans_id']}
  end

  def request_bet_details
    response = RestClient.post Rails.application.config_for(:api_data)['saba']['url'] + '/api/GetBetDetail', {vendor_id: vendor_id, wallet_id: wallet_id, version_key: version_key}
    response = JSON.parse(response.body)
    @error_code = response['error_code']
    @error_message = response['message']
    @bet_details = response['Data']['BetDetails']
  end

  def validate_errors
    @errors = {}
    unless error_code == 0
      @errors.merge!(error_code: error_code)
      @errors.merge!(message: error_message)
    end
  end

end