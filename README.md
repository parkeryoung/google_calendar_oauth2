Taken from https://github.com/unixcharles/google_calendar_api_v2 and modified for OAuth2
# Find & Create + Update & Delete

All you need to survive a syncronization project with Google Calendar using GData 3.0 + OAuth 2.0

# Usage

    require 'google_calendar'
    require 'sinatra'
    client = GoogleCalendar::Client.new "google_client_id", "google_client_secret", "/oauth2endpoint"

    redirect client.redirect_to
    
    get '/oauth2endpoint'
        client.connection.authorization.code = params['code']
        client.connection.authorization.fetch_access_token!
    end