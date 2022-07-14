IEX::Api.configure do |config|
  config.publishable_token = Rails.application.credentials.sandbox_publishable_token
  config.secret_token = Rails.application.credentials.sandbox_secret_token
  config.endpoint = "https://sandbox.iexapis.com/v1"
end
