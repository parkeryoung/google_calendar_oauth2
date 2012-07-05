module GoogleCalendar
  module Exceptions
    class Unauthorized < StandardError; end
    class Required < StandardError; end
    class InvalidData < StandardError; end
  end
end