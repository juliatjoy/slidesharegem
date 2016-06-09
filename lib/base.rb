require 'net/http'
require 'uri'
require 'faraday'

module SlideShare
  class Base
    API_BASE_URL "http://www.slideshare.net/api/2"
    format :xml

    attr_accessor :api_key, :shared_secret

    def initialize(api_key, shared_secret)
      @api_key = api_key
      @shared_secret = shared_secret
      connection_setup
    end

    def connection_setup
      @connection = Faraday.new(url: API_BASE_URL) do |faraday|
        faraday.request :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def valid_parameters
      time = Time.now.to_i
      hash = Digest::SHA1.hexdigest "#{@shared_secret}#{time_stamp}"
      {api_key: @api_key, ts: time_stamp, hash: hash}
    end
  end
end
