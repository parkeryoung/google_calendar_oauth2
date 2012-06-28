Taken from https://github.com/unixcharles/google_calendar_api_v2 and modified for OAuth2

All you need to survive a syncronization project with Google Calendar using GData 3.0 + OAuth 2.0

# Usage
  Create an application.rb file and put the following in it.

    require 'sinatra'
    require 'rubygems'
    require 'google_calendar_oauth2'

    client = GoogleCalendar::Client.new "google_client_id", "google_client_secret", "http://localhost:4567/oauth2callback"

    get '/?' do
      unless client.connection.authorization.access_token
        redirect client.redirect_to
      end
    end

    get '/oauth2callback' do
      client.connection.authorization.code = params['code']
      client.connection.authorization.fetch_access_token!
      redirect '/'
    end

  Create your Gemfile with the following.

    source 'http://rubygems.org'

    gem 'sinatra'
    gem 'google_calendar_oauth2'

  Finally, run 

    bundle exec ruby application.rb

  In your application directory and go to http://localhost:4567/

#Documentation
  For the time being it is scarce, but you can get an idea on how to use it from http://code.google.com/p/google-api-ruby-client/source/browse/calendar/calendar.rb?repo=samples