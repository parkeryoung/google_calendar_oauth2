module GoogleCalendar
  class Calendar
    def self.client
      GoogleCalendar.connection
    end

    def self.connection
      GoogleCalendar.connection.discovered_api('calendar', 'v3')
    end

    def self.list
      list = client.execute(connection.calendar_list.list)
      list.data.items
    end

    def self.find(query)
      list.each do |cal|
        if cal.summary == query
          return @cal = cal
        end
      end
      @cal
    end

    def self.create(attrs)
      client.execute(api_method: connection.calendars.insert, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end
  end
end