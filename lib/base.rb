require 'net/http'
require 'uri'

module SlideShare
  class Base
    API_BASE_URL "http://www.slideshare.net/api/2"
    format :xml

    attr_accessor :api_key, :shared_secret, :connection

    def initialize(api_key, shared_secret)
      @api_key = api_key
      @shared_secret = shared_secret
      connection_setup
    end

    def get(path, params)
      uri = URI.parse(API_BASE_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
    end

    # def connection_setup
    #   @connection = Faraday.new(url: API_BASE_URL) do |faraday|
    #     faraday.request :json
    #   end
    # end
  end
end
