require 'google/api_client'
require 'socket'

module GoogleCalendarApiV2
  class Client
    attr_reader :headers, :calendars, :events
    attr_accessor :connection
    HEADERS = {'Content-Type' => 'application/json', 'GData-Version' => '2.6'}

    def initialize(client_id, client_secret, redirect_uri)
      @client = Google::APIClient.new
      @client.authorization.client_id = client_id 
      @client.authorization.client_secret = client_secret 
      @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      @client.authorization.redirect_uri = redirect_uri
      @connection = @client
      @calendars = Calendar.new(@client)
    end
  end
end