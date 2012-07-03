module GoogleCalendar
  class Calendar

    attr_accessor :id, :etag, :summary, :description, :location, :timezone

    extend Connection

    def initialize(attrs = {})
      @id = params['id']
      @etag = params['etag']
      @summary = params['summary']
      @description = params['description']
      @location = params['location']
      @timezone = params['timeZone']
    end


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
      connection.execute(api_method: client.calendars.insert, body: [JSON.dump(attrs)], headers: {'Content-Type' => 'application/json'})
    end
  end
end