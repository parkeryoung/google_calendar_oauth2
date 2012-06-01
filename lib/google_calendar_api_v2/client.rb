require 'google/api_client'

module GoogleCalendarApiV2
  class Client
    attr_reader :connection, :headers, :calendars, :events

    HEADERS = {'Content-Type' => 'application/json', 'GData-Version' => '2.6'}

    def initialize(client_id, client_secret)
      @client = Google::APIClient.new
      @client.client_id = client_id 
      @client.client_secret = client_secret 
      @client.scope = 'https://www.googleapis.com/auth/calendar'
      @client.redirect_uri = to('/oauth2callback')
    end
  end
end