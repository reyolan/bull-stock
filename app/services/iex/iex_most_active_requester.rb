class Iex::IexMostActiveRequester
  def self.perform
    request_most_active_stocks
  end

  def self.request_most_active_stocks
    client = IEX::Api::Client.new
    client.stock_market_list(:mostactive)
  end

  private_class_method :request_most_active_stocks
end
