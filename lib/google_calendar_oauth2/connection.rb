module GoogleCalendar
  module Connection
    def connection
      @connection = GoogleCalendar.connection
    end

    def client
      @client = GoogleCalendar.connection.discovered_api('calendar', 'v3')
    end

    def execute(command)
      result = connection.execute(command)
      raise GoogleCalendar::Exceptions::Unauthorized if result.data['error']['code'] == 401
      result
    end
  end
end
