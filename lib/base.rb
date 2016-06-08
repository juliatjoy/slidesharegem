module slideshare
  class Base
    API_base_uri "http://www.slideshare.net/api/2"
    format :xml

    attr_accessor :api_key, :shared_secret

    def initialize(api_key, shared_secret)
      @api_key = api_key
      @shared_secret = shared_secret
    end
  end
end
