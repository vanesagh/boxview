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

    # url: url of a document in the cloud
    def self.create url
      BoxView.connection.post do |request|
        request.url @@endpoint
        request.body = '{"url": "' + url + '"}'
      end
    end

    def self.list
      BoxView.connection.get "documents"
    end

    def self.get id
      BoxView.connection.get "documents/#{id}"
    end

    # box_id of a processed document
    def self.get_zip id
      BoxView.connection.get "documents/#{id}/content.zip"
    end

  end
end
