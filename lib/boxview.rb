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
    # attributes: a hash with url (required), name, and thumbnails
    # url: string with url of a document in the cloud
    # thumbnails:  string with widthxheight dimensions "128x128,256x256"
    def self.create attributes
      BoxView.connection.post do |request|
        request.url "documents"
        attributes = { "url" => attributes[:url], "thumbnails" => attributes[:thumbnails] }
        request.body = attributes.to_json
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

    def self.get_thumbnail id, options
      BoxView.connection.get "documents/#{id}/thumbnail?width=#{options[:width]}&height=#{options[:height]}"
    end

  end

=begin
  module Sessions
    @@endpoint = "sessions"

    def self.create document_id
      BoxView.connection.post do |request|
        request.url @@endpoint
        request.body = '{"document_id": "' + document_id + '"}'
      end
    end
  end

  # Gets a session to view the link, should be in box api wrapper
  def get_box_session
    box_url = 'https://view-api.box.com/1'
    connection = Faraday.new box_url do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end

    result = connection.post do |req|
      req.url 'sessions'
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Token SsLuBXaj1bGczeOtD9VxIYl0QpNC3ndM"
      req.body = '{"document_id": "' + self.document.box_id + '"}'
    end
    result.env[:body]["id"]
  end
=end

end
