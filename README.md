

# 🌊 TideGuard: Your Ultimate Flood Safety Companion

TideGuard is an iOS application designed to help people living in flood-prone areas, particularly in Nigeria stay safe and informed. It provides real time flood alerts, weather updates, and evacuation routes, all within a clean and intuitive interface.
This project is currently under development as part of my final year diplom work .

## 🧭 Overview
Flooding remains a major environmental and safety issue in Nigeria, especially in coastal cities like Lagos. TideGuard aims to reduce risk and enhance preparedness by delivering accurate, location based information directly to users.
Whether you need to:
Check flood prone zones on an interactive map 🗺️
Stay updated with current weather conditions ☀️🌧️
Locate nearby evacuation shelters and safe routes 🏠
TideGuard keeps you informed and ready anytime, anywhere.

## How It Works 🛠️
It has  a two part setup:
- **Frontend (iOS)** 📱: Built with Swift, using Alamofire for network calls, MapKit for maps, and SnapKit for layouts. The app talks to the backend to grab flood and weather data, then displays it with a neat UI featuring tabs and weather icons! 🌤️
- **Backend (Spring Boot)** ⚙️: A Java Spring Boot server that fetches weather data from Open-Meteo, handles flood area info, and serves it all to the iOS app via REST APIs. We use RestTemplate for API calls, JPA for user data, and JSON parsing for weather details.

## Tech Stack 🚀
- **iOS**: Swift, Alamofire, MapKit, SnapKit
- **Backend**: Spring Boot, RestTemplate, JPA (UserRepository), Open-Meteo API
- **APIs**: Open-Meteo (weather), Nominatim (geocoding)

## Why TideGuard?
Living in flood prone regions can be unpredictable and stressful. TideGuard was built to empower users with data driven insights for safety and awareness.
By combining weather forecasts, location data, and smart UI design, TideGuard helps users make informed decisions in critical moments and hopefully, stay one step ahead of the storm.

TideGuard is currently in active development.

