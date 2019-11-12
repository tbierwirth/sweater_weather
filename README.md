# Sweater Weather
An API built out in Ruby on Rails that consumes Darksky API and Google's Geocoding and Directions APIs. Allows users to register to receive an API key which they can use to retrieve the forecast of a location, get a background image for a location based on the current weather and receive the location of a destination for a roadtrip based on time of arrival.

## Setup
### Initial Setup
- Run `bundle install` to install gems.
- Run `rails db:{create,migrate}` to create and migrate the database.
- Run `bundle exec figaro install` and edit the `config/application.yml` to setup your API keys:
```
GOOGLE_API_KEY: 
DARKSKY_API_KEY: 
BING_API_KEY: 
```

### Server
- Run `rails s` and connect on http://localhost:3000

### Testing
- Run `bundle exec rspec`

## Endpoints
### Registration (`/api/v1/users`)
Create an account and receive an API key

| Params | Description                                |
|------------|--------------------------------------------|
| email       | Must be unique        |
| password | Must match password_confirmation        |
| password_confirmation | Must match password        |

Example Request:
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

Example Response: 
```
status: 201
body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4",
}
```

### Login (`/api/v1/sessions`)
Login to retrieve your API key

| Params | Description                                |
|------------|--------------------------------------------|
| email       | Must be unique        |
| password | Must match password_confirmation        |

Example Request: 
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

Example Response:
```
status: 200
body:

{
  "api_key": "jgn983hy48thw9begh98h4539h4",
}
```

### Forecast (`/api/v1/forecast`)
Retrieve forecast for a location (Ex. Denver, CO)

| Params  | Description                                |
|------------|--------------------------------------------|
| location       | City/State        |

Example Request:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

Example Response:
```
{
    "data": {
        "id": "1573580083",
        "type": "forecast",
        "attributes": {
            "id": 1573580083,
            "current": {
                "time": 1573580083,
                "summary": "Clear",
                "icon": "clear-day",
                "nearestStormDistance": 381,
                "nearestStormBearing": 337,
                "precipIntensity": 0,
                "precipProbability": 0,
                "temperature": 48.65,
                "apparentTemperature": 47.77,
                "dewPoint": 19.11,
                "humidity": 0.31,
                "pressure": 1021.8,
                "windSpeed": 4.44,
                "windGust": 9.83,
                "windBearing": 152,
                "cloudCover": 0.15,
                "uvIndex": 3,
                "visibility": 10,
                "ozone": 283.2
            },
            "location": "denver,co",
            "hourly": {
                "summary": "Clear throughout the day.",
                "icon": "clear-day",
                "data": [
                    {
                        "time": 1573578000,
                        "summary": "Clear",
                        "icon": "clear-day",
                        "precipIntensity": 0,
                        "precipProbability": 0,
                        "temperature": 44.15,
                        "apparentTemperature": 41.83,
                        "dewPoint": 19.53,
                        "humidity": 0.37,
                        "pressure": 1023.4,
                        "windSpeed": 4.35,
                        "windGust": 10.39,
                        "windBearing": 155,
                        "cloudCover": 0.15,
                        "uvIndex": 2,
                        "visibility": 10,
                        "ozone": 282.7
                    },
                    {...},
```

### Background Images (`/api/v1/backgrounds`)
Get background images based on location and current weather

Example Request:
```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

### Roadtrip (`/api/v1/road_trip`)
Get forecast of a destination for a road trip based on time of arrival 

| Params | Description                                |
|------------|--------------------------------------------|
| origin       | Starting point        |
| destination | Ending point        |
| api_key | Your unique api key        |

Example Request:
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Aspen,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

Example Response:
```
status: 200
body:

{
    "data": {
        "id": "1573592072",
        "type": "road_trip",
        "attributes": {
            "id": 1573592072,
            "origin": "Denver, CO",
            "destination": "Aspen, CO",
            "duration": "3 hours 32 mins",
            "summary": "Clear",
            "temperature": 51.36,
            "humidity": 0.11,
            "precipitation_chance": 0.01
        }
    }
}
```

## Tech Stack
- Ruby (2.4.1)
- Rails (5.2.3)
- ActiveRecord  
- Postgres
- RSpec

## How To Contribute
If you would like to contribute, take a look at current open issues and make a pull request with your contribution.
