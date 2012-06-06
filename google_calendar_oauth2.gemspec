Gem::Specification.new do |s|
  s.name        = 'google_calendar_api_v2'
  s.version     = '0.1.3'
  s.summary     = "Work with Google Calendar using GData 3.0 + OAuth 2.0"
  s.author      = ['Parker Young']
  s.email       = 'parker.young@collegeplus.org'
  s.homepage    = 'http://www.github.com/parkeryoung/google_calendar_oauth2'

  s.files        = Dir['README.md', 'LICENSE',
                       'lib/google_calendar_api_v2.rb',
                       'lib/google_calendar_api_v2/client.rb',
                       'lib/google_calendar_api_v2/calendar.rb',
                       'lib/google_calendar_api_v2/event.rb',
                     ]

  s.require_path = 'lib'

  s.add_runtime_dependency 'google-api-client'
end