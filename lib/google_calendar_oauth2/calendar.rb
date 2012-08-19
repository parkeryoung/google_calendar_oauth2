module GoogleCalendar
  class Calendar
    extend Connection

    def self.list
      list = connection.execute(client.calendar_list.list)
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
      connection.execute(
        api_method: client.calendars.insert,
        body: [JSON.dump(attrs)],
        headers: { "Content-Type" => "application/json" }
      )
    end
    alias :insert :create

    def self.update(calendar_id, attrs)
      connection.execute(
        :api_method => client.calendars.update,
        :parameters => { "calendarId" => calendar_id },
        :body_object => [JSON.dump(attrs)],
        :headers => { "Content-Type" => "application/json" }
      )
    end

    def self.delete(calendar_id)
      connection.execute(
        api_method: client.calendars.delete,
        parameters: { "calendarId" => calendar_id }
      )
    end
  end
end
