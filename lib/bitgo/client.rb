module Bitgo
  class Client < Request
    attr_accessor :access_token
    BASE_URL= 'https://test.bitgo.com/api/v2'
    include ::Api::User

    def initialize(access_token)
      @api_key = access_token
    end

    private

    def request_url(path)
      "#{BASE_URL}/#{path}"
    end
   
     def headers
       { "Authorization": "Bearer #{api_key}" }
     end
  end
end
