require 'google/api_client'
require 'socket'

module GoogleCalendar
  class Client
    attr_reader :headers, :calendars, :events
    attr_accessor :connection
    HEADERS = {'Content-Type' => 'application/json', 'GData-Version' => '3.0'}

    def initialize(client_id, client_secret, redirect_uri)
      @connection = Google::APIClient.new
      @connection.authorization.client_id = client_id 
      @connection.authorization.client_secret = client_secret 
      @connection.authorization.scope = 'https://www.googleapis.com/auth/calendar'
      @connection.authorization.redirect_uri = redirect_uri
    end

    def redirect_to
      @connection.authorization.authorization_uri.to_s
    end

    def calendars
      @calendars = Calendar.new(@connection)
    end

    def events
      Event.new(@connection)
    end
  end
end