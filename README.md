

# 🌊 TideGuard: Your Ultimate Flood Safety Buddy! 🚨

Hey there, welcome to **TideGuard**! 🌟 This isn’t just an app—it’s your go-to pal for staying safe during floods, especially if you’re in a flood-prone spot like Lagos Nigeria! I am  building this app to keep you in the loop with real-time flood info, weather updates, and evacuation plans, all wrapped in a sleek iOS experience. Let’s dive in! 🏊‍♂️
Currently in the works as I am buiding this as my coursework for this semester(second semester, third year).

## What’s TideGuard All About? 🤔
TideGuard is here to help you navigate flood risks in Nigeria like a pro! Whether you’re checking flood zones on a map 🗺️, getting the latest weather updates ☀️🌧️, or finding the nearest evacuation shelters 🏠, we’ve got your back. Here’s the cool stuff you can do:

- **Flood Area Maps** 🗺️: See flood-prone zones in your city with an interactive map—powered by MapKit on iOS!
- **Weather Updates** ☁️: Get real-time weather info (temp, humidity, and more) for your city, fetched from Open-Meteo via our Spring Boot backend.
- **Evacuation Info** 🚪: Find shelters and routes to safety, tailored to your location.
- **Pretty UI** ✨: A clean, segmented interface! 

## How It Works 🛠️
It has  a two-part setup:
- **Frontend (iOS)** 📱: Built with Swift, using Alamofire for network calls, MapKit for maps, and SnapKit for layouts. The app talks to the backend to grab flood and weather data, then displays it with a neat UI featuring tabs and weather icons! 🌤️
- **Backend (Spring Boot)** ⚙️: A Java Spring Boot server that fetches weather data from Open-Meteo, handles flood area info, and serves it all to the iOS app via REST APIs. We use RestTemplate for API calls, JPA for user data, and JSON parsing for weather details.

## Tech Stack 🚀
- **iOS**: Swift, Alamofire, MapKit, SnapKit
- **Backend**: Spring Boot, RestTemplate, JPA (UserRepository), Open-Meteo API
- **APIs**: Open-Meteo (weather), Nominatim (geocoding)

## Why I decide on this idea?💡
Living in flood-prone areas can be stressful 😓, but we wanted to make safety *easy* and *fun*! TideGuard gives you the info you need to stay prepared, whether you’re planning your day or need to evacuate fast. 

