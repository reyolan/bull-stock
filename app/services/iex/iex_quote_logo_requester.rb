class IexQuoteLogoRequester
  def initialize(symbol)
    @symbol = symbol
  end

  def perform
    client = IEX::Api::Client.new
    quote = client.quote(@symbol)
    logo = client.logo(@symbol)
    OpenStruct.new(success?: true, quote:, logo:)
  rescue IEX::Errors::SymbolNotFoundError => e
    OpenStruct.new(success?: false, message: e.message)
  end
end
