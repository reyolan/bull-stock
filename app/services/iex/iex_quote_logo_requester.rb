class Iex::IexQuoteLogoRequester
  def initialize(symbol)
    @symbol = symbol
  end

  def perform
    client = IEX::Api::Client.new
    quote = client.quote(@symbol)
    logo = client.logo(@symbol)
    Struct.new(:success?, :quote, :logo).new(true, quote, logo)
  rescue IEX::Errors::SymbolNotFoundError => e
    Struct.new(:success?, :message).new(false, e.message)
  end
end
