module GoogleCalendar
  class Event
    def self.connection
      GoogleCalendar.connection
    end

    def self.client
      GoogleCalendar.connection.discovered_api('calendar', 'v3')
    end

    def self.list(calendar_id)
      list = connection.execute(api_method: client.events.list, parameters: { 'calendarId' => calendar_id })
      list.data.items
    end

    def self.find_by_name(calendar_id, query)
      list(calendar_id).each do |event|
        if event.summary == query
          return @event = event
        end
      end
      @event
    end

    def self.find_by_id(calendar_id, id)
      connection.execute(api_method: client.events.get, parameters: { 'calendarId' => calendar_id, 'eventId' => id }).data
    end

    def self.create(calendar_id, attrs)
      connection.execute(api_method: client.events.insert, parameters: { 'calendarId' => calendar_id }, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end

    def self.update(calendar_id, event_id, attrs)
      sequence = self.find_by_id(calendar_id, event_id).sequence
      sequence = sequence.nil? ? 1 : sequence + 1
      connection.execute(api_method: client.events.update, parameters: { 'calendarId' => calendar_id, 'eventId' => event_id }, body: [JSON.dump(attrs.merge('sequence' => sequence))], headers: {'Content-Type' => 'application/json'})
    end
  
    def self.delete(calendar_id, event_id)
      connection.execute(api_method: client.events.delete, parameters: { 'calendarId' => calendar_id, 'eventId' => event_id })
    end
  end
end