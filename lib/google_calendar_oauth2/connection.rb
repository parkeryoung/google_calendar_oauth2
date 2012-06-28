module GoogleCalendar
  module Connection
    def connection
      @connection = GoogleCalendar.connection
    end

    def client
      @client = GoogleCalendar.connection.discovered_api('calendar', 'v3')
    end  
  end
end
