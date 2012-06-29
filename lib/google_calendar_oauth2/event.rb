module GoogleCalendar
  class Event
    attr_accessor :id, :calendar_id, :sequence, :etag, :status, :html_link, :created_at, :updated_at

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
    end

    def to_s
    "#&lt;Event id: #{self.id}, calendar_id: #{self.calendar_id}, sequence: #{self.sequence}, etag: #{self.etag}, status: #{self.status}, html_link: #{self.html_link}, created_at: #{self.created_at}, updated_at: #{self.updated_at}&gt;"
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
      new connection.execute(api_method: client.events.get, parameters: { 'calendarId' => calendar_id, 'eventId' => id }).data.to_hash.merge 'calendar_id' => calendar_id
    end

    def self.create(calendar_id, attrs)
      new connection.execute(api_method: client.events.insert, parameters: { 'calendarId' => calendar_id }, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'}).data.to_hash.merge 'calendar_id' => calendar_id
    end

    def update(attrs)
      sequence = sequence.nil? ? 1 : sequence + 1
      new connection.execute(api_method: client.events.update, parameters: { 'calendarId' => calendar_id, 'eventId' => event_id }, body: [JSON.dump(attrs.merge('sequence' => sequence))], headers: {'Content-Type' => 'application/json'})
    end
  
    def self.delete(calendar_id, event_id)
      connection.execute(api_method: client.events.delete, parameters: { 'calendarId' => calendar_id, 'eventId' => event_id })
    end
  end
end