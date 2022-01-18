require 'rails_helper'

describe Marvel::Api do
  describe '.new' do
    it 'returns a Marvel::Client' do
      expect(Marvel::Api.new).to be_a Marvel::Client
    end
  end

  describe '.configure' do
    it 'sets the api_key and private_key' do
      Marvel::Api.configure do |config|
        config.api_key = '1234'
        config.private_key = 'abcd'
      end

      expect(Marvel::Api.api_key).to eq '1234'
      expect(Marvel::Api.private_key).to eq 'abcd'
    end
  end
end