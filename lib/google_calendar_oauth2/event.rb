module GoogleCalendar
  class Event
    attr_accessor :id, :calendar_id, :start_time, :end_time, :sequence, :etag, :status, :html_link, :created_at, :updated_at

    extend Connection

    def initialize(attrs)
      self.id = attrs['id']
      self.etag = attrs['etag']
      self.status = attrs['status']
      self.html_link = attrs['htmlLink']
      self.created_at = attrs['created']
      self.updated_at = attrs['updated']
      self.calendar_id = attrs['calendar_id']
      self.sequence = attrs['sequence']
      self.start_time = attrs['start']['dateTime']
      self.end_time = attrs['end']['dateTime']
    end

    alias attributes= initialize

    def to_s
    "#&lt;Event id: #{self.id}, start_time: #{self.start_time}, end_time: #{self.end_time}, calendar_id: #{self.calendar_id}, sequence: #{self.sequence}, etag: #{self.etag}, status: #{self.status}, html_link: #{self.html_link}, created_at: #{self.created_at}, updated_at: #{self.updated_at}&gt;"
    end

    def attributes
      {
        id: id,
        etag: etag,
        status: status,
        html_link: html_link,
        created_at: created_at,
        updated_at: updated_at,
        calendar_id: calendar_id,
        sequence: sequence,
        start: {
          :dateTime => start_time
        },
        end: { 
          :dateTime => end_time
        }
      }
    end

    def self.list(calendar_id)
      list = connection.execute(api_method: client.events.list, parameters: { 'calendarId' => calendar_id })
      events = []
      list.data.items.each do |event|
        events << new(event)
      end
      events
    end

    def self.find_by_name(calendar_id, query)
      list(calendar_id).each do |event|
        if event.summary == query
          return @event = new(event.merge({ 'calendar_id' => calendar_id }))
        end
      end
      @event
    end

    def self.find_by_id(calendar_id, id)
      new connection.execute(
        api_method: client.events.get, 
        parameters: { 
          'calendarId' => calendar_id, 
          'eventId' => id 
        }
      ).data.to_hash.merge 'calendar_id' => calendar_id
    end

    def self.create(calendar_id, attrs)
      new connection.execute(
        api_method: client.events.insert, 
        parameters: { 'calendarId' => calendar_id }, 
        body: [JSON.dump(attrs)], 
        headers: {'Content-Type' => 'application/json'}
      ).data.to_hash.merge 'calendar_id' => calendar_id
    end

    def update(attrs = {})
      self.sequence = self.sequence.nil? ? 1 : self.sequence + 1
      attrs = self.attributes.merge attrs
      result = Event.connection.execute(
        api_method: Event.client.events.update, 
        parameters: { 
          'calendarId' => self.calendar_id, 
          'eventId' => self.id 
        }, 
        body: [JSON.dump(attrs)], 
        headers: {'Content-Type' => 'application/json'}
      ).data.to_hash.merge('calendar_id' => self.calendar_id)
      self.attributes = result
      self
    end
  
    def self.delete(calendar_id, event_id)
      connection.execute(
        api_method: client.events.delete, 
        parameters: { 
          'calendarId' => calendar_id, 
          'eventId' => event_id 
        }
      )
    end
  end
end