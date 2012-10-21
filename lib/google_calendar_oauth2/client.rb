require "google/api_client"
require "socket"

module GoogleCalendar
  def self.connection=(connection)
    @connection = connection
  end

  def self.connection
    @connection
  end

  class Client
    extend Connection

    def initialize(client_id, client_secret, redirect_uri)
      GoogleCalendar.connection = Google::APIClient.new
      GoogleCalendar.connection.authorization.client_id = client_id
      GoogleCalendar.connection.authorization.client_secret = client_secret
      GoogleCalendar.connection.authorization.scope = "https://www.googleapis.com/auth/calendar"
      GoogleCalendar.connection.authorization.redirect_uri = redirect_uri
    end

    def redirect_to
      GoogleCalendar.connection.authorization.authorization_uri.to_s
    end
  end
end
