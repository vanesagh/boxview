require 'faraday_middleware'

module Box
  module View
    def self.init token
      @@api_token = token 
    end

    def self.api_url
      "https://view-api.box.com/1"
    end

    def self.conn
      Faraday.new(:url => self.api_url) do |conn|
        conn.basic_auth @@api_id, @@api_secret
        conn.request  :url_encoded # convert request params as "www-form-urlencoded"
        conn.response :mashify
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    module Documents

      def create url 
        Box::View.connection.post do |req|
          req.url 'documents'
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "Token #{Box::View.token}"
          req.body = '{"url": "' + url + '"}'
        end
      end

    end
  end
end
