require 'rest-client'
module Bitgo
  class Request
    def get(url)
      data = RestClient.get(request_url(url), headers)
    end

    def post(url, params = {})
      RestClient.post(request_url(url), params, headers)
    end
  end
end
