require 'faraday'
require 'faraday_middleware'
require 'nokogiri'
require './lib/slideshow'

module SlideShare
  class Base
    API_BASE_URL = "https://www.slideshare.net/api/2"

    attr_accessor :api_key, :shared_secret

    def initialize api_key, shared_secret
      @api_key = api_key
      @shared_secret = shared_secret
      connection_setup
    end

    def get_slideshow params
      get('get_slideshow', params)
    end

    def get_by_tag params
      get('get_slideshows_by_tag', params)
    end

    def get_by_user params
      get('get_slideshows_by_user', params)
    end

    def search_slideshow params
      get('search_slideshow', params)
    end

    def user_favourites params
      get('get_user_favourites', params)
    end

    def user_contacts params
      get('get_user_contacta', params)
    end

    def user_tags params
      get('get_user_tags', params)
    end

    def edit_slideshow params
      get('edit_slideshow', params)
    end

    def delete_slideshow
      get('delete_slideshow', params)
    end

    def upload_slideshow
      get('upload_slideshow', params)
    end

    private

    def connection_setup
      @connection = Faraday.new(url: API_BASE_URL) do |faraday|
        faraday.request :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def valid_params
      time = Time.now.to_i
      hash = Digest::SHA1.hexdigest "#{@shared_secret}#{time}"
      {api_key: @api_key, ts: time, hash: hash}
    end

    def get path, params
      SlideShare::SlideShow.new Nokogiri::XML(@connection.get(path , valid_params.merge(params)).body)
    end
  end
end
