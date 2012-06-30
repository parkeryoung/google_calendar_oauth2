Gem::Specification.new do |s|
  s.name        = 'google_calendar_oauth2'
  s.version     = '0.0.4'
  s.summary     = "Work with Google Calendar using GData 3.0 + OAuth 2.0"
  s.description = "Work with Google Calendar using GData 3.0 + OAuth 2.0"
  s.authors     = ['Parker Young']
  s.email       = 'parker.young@collegeplus.org'
  s.homepage    = 'http://www.github.com/parkeryoung/google_calendar_oauth2'
  s.required_rubygems_version = '>= 1.3.6'
  s.files        = s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.add_dependency 'google-api-client'
end