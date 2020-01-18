class SabaWithdrawDepositService
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