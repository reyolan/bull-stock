class Iex::IexQuoteLogoRequester
  def initialize(symbol)
    @symbol = symbol
  end

  def perform
    request_quote_and_logo
  end

  private

  def request_quote_and_logo
    client = IEX::Api::Client.new
    quote = client.quote(@symbol)
    logo = client.logo(@symbol)
    Struct.new(:success?, :quote, :logo).new(true, quote, logo)
  rescue IEX::Errors::SymbolNotFoundError => e
    Struct.new(:success?, :message).new(false, e.message)
  end
end
