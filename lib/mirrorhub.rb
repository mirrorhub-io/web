require 'json'
class Mirrorhub
  class API
    class Client
      attr_reader :location
      attr_accessor :token, :headers
      def initialize(location, token: nil)
        @location = location
        @token = token
        @headers = {'Grpc-Metadata-ContactToken': token}
      end

      def auth
        res = post('contacts/auth',
                   headers: {'Grpc-Metadata-ContactEmail': mail,
                             'Grpc-Metadata-ContactPassword': password})

        true if @token = res['token']
      end

      def get(resource, params: {})
        request = Typhoeus::Request.new(
          "#{@location}/#{resource}",
          method: :get,
          params: params,
          headers: headers
        )
        res = request.run
        JSON.parse(res.response_body)
      end

      def post(resource, body: {})
        request = Typhoeus::Request.new(
          "#{@location}/#{resource}",
          method: :post,
          body: body.to_json,
          headers: headers
        )
        res = request.run
        puts res.inspect
        JSON.parse(res.response_body)

      end

    end
  end
end
