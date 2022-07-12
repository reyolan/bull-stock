class ApplicationService
  private

  def iex_client
    @client = IEX::Api::Client.new
  end
end