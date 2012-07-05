module GoogleCalendar
  class Calendar

    attr_accessor :id, :etag, :summary, :description, :location, :timezone

    extend Connection
    include Utils

    def initialize(attrs = {})
      @id = attrs['id']
      @etag = attrs['etag']
      @summary = attrs['summary']
      @description = attrs['description']
      @location = attrs['location']
      @timezone = attrs['timeZone']
    end

    alias attributes= initialize

    def attributes
      {
        id: @id,
        etag: @etag,
        summary: @summary,
        description: @description,
        location: @location,
        timeZone: @timezone
      }
    end

    def events
      GoogleCalendar::Event.list(self.id)
    end

    def self.list
      calendars = []
      list = execute(client.calendar_list.list)
      list.data.items.each do |calendar|
        calendars << new(calendar)
      end
      calendars
    end

    def self.find(query)
      list.each do |cal|
        if cal.summary == query
          return @cal = cal
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
      calendar = execute(api_method: client.calendars.insert, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
      new calendar.data
    end

    def update(attrs)
      attrs = self.attributes.merge(attrs)
      result = Calendar.execute( 
        api_method: Calendar.client.calendars.update, 
        parameters: { 
          'calendarId' => self.id
        }, 
        body: [JSON.dump(attrs)], 
        headers: {'Content-Type' => 'application/json'}
      ).data.to_hash
      self.attributes = result
      self
    end
  end
end