module GoogleCalendarApiV2
  class Event
    include Base

    attr_reader :client, :connection

    def initialize(client)
      @client = client
      @connection = client.discovered_api('calendar', 'v3')
    end

    def list(calendar)
      list = @client.execute(api_method: @connection.events.list, parameters: { 'calendarId' => calendar.id })
      list.data.items
    end

    def find(calendar, query)
      list.each do |event|
        if event.summary == query
          return @event = event
        end
      end
      @event
    end

    def create(calendar, attrs)
      @client.execute(api_method: @connection.events.insert, parameters: { 'calendarId' => calendar.id }, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end

    def update(calendar, event_id, attrs)
      @client.execute(api_method: @connection.events.update, parameters: { 'calendarId' => calendar.id, 'eventId' => event_id }, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end
  end
end