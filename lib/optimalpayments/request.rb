require 'uri'
require "yaml"

module OptimalPayments
  class Request
    POST = "POST";
    GET = "GET";
    DELETE = "DELETE";
    PUT = "PUT";

    # stores data for netbanx api client
    @data = nil

    attr_accessor :data

    # Build url for the netbanx api client.
    def build_url api_end_point
      if @data[:url].nil?
        return api_end_point + @data[:uri] + "?" +
          URI.encode(@data[:query].map{|k,v| "#{k}=#{v}"}.join("&"))
      end

      if @data[:url].index(api_end_point) != 0
        raise OptimalError, "Unexpected endpoint in url: #{@data[:url]} expected: #{api_end_point}"
      end

      return @data[:url]
    end

    def initialize args
      self.data = {
        uri: '',
        method: Request::GET,
        body: nil,
        query: {},
        url: nil
      }
      if args.is_a?(Hash)
        args.each do |key, value|
          self.data[key.to_sym] = value
        end
      elsif args.is_a?(OptimalPayments::Link)
        self.data[:url] = args[:href]
      end
    end
  end
end