Rails.application.reloader.to_prepare do
  MARVEL = Marvel::Client.new.tap do |client|
    client.configure do |config|
      config.api_key = Rails.application.credentials.marvel[:public]
      config.private_key = Rails.application.credentials.marvel[:private]
    end
  end
end
