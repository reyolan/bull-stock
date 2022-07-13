class Iex::IexMostActiveRequester
  def self.perform
    client = IEX::Api::Client.new
    client.stock_market_list(:mostactive)
  end
end
