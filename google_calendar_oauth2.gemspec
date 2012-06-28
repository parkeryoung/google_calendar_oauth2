Gem::Specification.new do |s|
  s.name        = 'google_calendar_oauth2'
  s.version     = '0.0.2'
  s.summary     = "Work with Google Calendar using GData 3.0 + OAuth 2.0"
  s.authors      = ['Parker Young']
  s.email       = 'parker.young@collegeplus.org'
  s.homepage    = 'http://www.github.com/parkeryoung/google_calendar_oauth2'

  s.files        = Dir['README.md', 'LICENSE',
                       'lib/google_calendar_oauth2.rb',
                       'lib/google_calendar_oauth2/client.rb',
                       'lib/google_calendar_oauth2/calendar.rb',
                       'lib/google_calendar_oauth2/event.rb',
                       'lib/google_calendar_oauth2/connection.rb',
                    ]

  s.require_path = 'lib'

  s.add_dependency 'google-api-client'
end