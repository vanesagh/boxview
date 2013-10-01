require 'faraday_middleware'

module BoxView
  def self.init token
    @@api_token = token 
  end

  def self.api_url
    "https://view-api.box.com/1"
  end

  def self.connection
    connection = Faraday.new(:url => BoxView.api_url) do |conn|
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end
    connection.headers['Authorization'] = "Token #{@@api_token}"
    connection.headers['Content-Type'] = 'application/json'
    return connection
  end

  module Documents
    @@endpoint = "documents"

    # takes the url of where the document is in the cloud
    def self.create url 
      BoxView.connection.post do |request|
        request.url @@endpoint
        request.body = '{"url": "' + url + '"}'
      end
    end

    def self.get_zip box_id
      BoxView.connection.get "documents/#{box_id}/content.zip"
    end

  end
end
