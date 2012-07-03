module GoogleCalendar
  class Calendar

    attr_accessor :id, :etag, :summary, :description, :location, :timezone

    extend Connection

    def initialize(attrs = {})
      @id = attrs['id']
      @etag = attrs['etag']
      @summary = attrs['summary']
      @description = attrs['description']
      @location = attrs['location']
      @timezone = attrs['timeZone']
    end

    def events
      GoogleCalendar::Event.list(self.id)
    end

    def self.list
      calendars = []
      list = connection.execute(client.calendar_list.list)
      list.data.items.each do |calendar|
        calendars << new(calendar)
      end
      calendars
    end

    def self.find(query)
      list.each do |cal|
        if cal.summary == query
          return @cal = new(cal)
        end
      end
      @cal
    end

    def create_event(attrs={})
      GoogleCalendar::Event.create(self.id, attrs)
    end

    def event_by_name(query)
      GoogleCalendar::Event.find_by_name(self.id, query)
    end

    def event_by_id(event_id)
      GoogleCalendar::Event.find_by_id(self.id, event_id)
    end

    def self.create(attrs)
      calendar = connection.execute(api_method: client.calendars.insert, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
      new calendar.data
    end
  end
end