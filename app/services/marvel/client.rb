require_relative 'request'
require_relative 'connection'
require_relative 'configuration'

module Marvel
  class Client
    include Marvel::Request
    include Marvel::Connection
    include Marvel::Configuration

    def initialize
      reset
    end

    def characters(options = {})
      # v1/public/characters
      get('characters', options)
    end

    def character(id, options = {})
      # v1/public/characters/{characterId}
      get("characters/#{id}", options)
    end
  end
end