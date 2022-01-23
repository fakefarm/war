require 'webmock/rspec'

def marvel_test_client
  Marvel::Client.new.tap do |client|
    client.configure do |config|
      config.api_key = '1234'
      config.private_key = 'abcd'
    end
  end
end

AUTH = '?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150'

def stub_get(_path, options = {})
  file = options.delete(:returns)
  code = options.delete(:response_code) || 200
  etag = options.delete(:etag)
  headers = Marvel::Connection::HEADERS
  headers.merge!('If-None-Match' => etag) if etag
  params = '&' + options.map { |k, v| "#{k}=#{v}" } * '&'
  endpoint = Marvel::Connection::BASE_API_URL
  stub_request(:get, /#{endpoint}/).with(headers: headers).to_return(body: fixture(file), status: code)
end

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
rescue StandardError
  nil
end

module Marvel
  module Request
    private

    def timestamp
      '1'
    end
  end
end
