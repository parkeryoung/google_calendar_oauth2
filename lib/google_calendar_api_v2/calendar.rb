module GoogleCalendarApiV2
  class Calendar
    include Base

    attr_reader :events, :connection, :client

    def initialize(client)
      @client = client
      @connection = @client.discovered_api('calendar', 'v3')
    end

    def list
      list = client.execute(connection.calendar_list.list)
      list.data.items
    end

    def find(query)
      list.each do |cal|
        if cal.summary == query
          return @cal = cal
        end
      end
      @cal
    end

    def create(attrs)
      @client.execute(api_method: @connection.calendars.insert, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end
  end
end