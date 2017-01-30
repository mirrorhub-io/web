require 'json'
class Mirrorhub
  class API
    class Client
      attr_reader :location
      attr_accessor :token
      def initialize(location)
        @location = location
      end

      def auth
        res = post('contacts/auth',
                   headers: {'Grpc-Metadata-ContactEmail': mail,
                             'Grpc-Metadata-ContactPassword': password})

        true if @token = res['token']
      end

      def get(resource, params: {}, headers: {})
        request = Typhoeus::Request.new(
          "#{@location}/#{resource}",
          method: :get,
          params: params,
          headers: headers
        )
        res = request.run
        JSON.parse(res.response_body)
      end

      def post(resource, params: {}, headers: {}, body: {})
        request = Typhoeus::Request.new(
          "#{@location}/#{resource}",
          method: :post,
          params: params,
          body: body.to_json,
          headers: headers
        )
        res = request.run
        JSON.parse(res.response_body)

      end

    end
  end
end
