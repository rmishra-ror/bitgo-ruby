module Bitgo
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => Bitgo::Error::BadRequest,
          401 => Bitgo::Error::Unauthorized,
          403 => Bitgo::Error::Forbidden,
          404 => Bitgo::Error::NotFound,
          429 => Bitgo::Error::RateLimited,
          500 => Bitgo::Error::InternalServerError,
          502 => Bitgo::Error::ProxyError
        }
      end

      def on_complete(response)
        klass = errors[response&.http_code&.to_i] || Bitgo::Error::Unknown
        fail klass.new(klass.new(response.inspect)) # rubocop:disable RaiseArgs
      end
    end

    # Raised when Bitgo returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Bitgo returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Bitgo returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when Bitgo returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when Bitgo returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Bitgo returns the HTTP status code 429
    RateLimited = Class.new(ClientError)

    # Raised when Bitgo returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when Bitgo returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Bitgo returns the HTTP status code 502
    ProxyError = Class.new(ServerError)

    # Raised when Bitgo returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when Bitgo returns unknown status code
    Unknown = Class.new(self)
  end
end
