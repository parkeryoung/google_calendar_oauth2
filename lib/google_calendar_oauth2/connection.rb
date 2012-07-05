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
      raise GoogleCalendar::Exceptions::Unauthorized if result.data.to_hash.fetch('error', {}).fetch('code', false) == 401
      raise GoogleCalendar::Exceptions::Required if result.data.to_hash.fetch('error', {}).fetch('message', false) == "Required" 
      raise GoogleCalendar::Exceptions::InvalidData if result.data.to_hash.fetch('error', {}).fetch('message', false) == "Invalid Value"
      result
    end
  end
end
