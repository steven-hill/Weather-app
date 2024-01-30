# Weather-app

## A SwiftUI app that uses the Open Weather API to get the current weather for the user's location.

  - A SwiftUI app written in Swift 5.9 with Xcode 15.1.
  - The iOS deployment target is 17.0.
  - It's a single view iOS app with a widget extension, supporting a small and medium sized widget.
  - It uses CoreLocation to get the user's location (if the user grants permission). Then it makes two network calls using the Open Weather API to get the current weather data and the AQI data for that location.
  - The app then displays the data on screen or presents an alert if an error has occurred.
  - Network code uses the Result type and completion handlers.
  - To handle different size classes I used GeometryReader, removing many hard coded values which I had initially used when building out the UI.
  - There is a floating button in the bottom right corner which the user can use to refresh the data.
  - I've added accessibility information about some views and the refresh button.
  - It also uses WidgetKit for the home screen widgets (small and medium sizes are supported), which provide glanceable information for the user on their home screen.
  - The app uses XCTest (and a bit of Combine) for unit tests to test the weather view model. The test coverage overall is 75%.
  - This app has allowed me to learn and practice MVVM, more frameworks (SwiftUI, CoreLocation, WidgetKit and XCTest), dependency injection and using Instruments to check for memory leaks.
  - By practicing and picking up these frameworks I delved a lot into Apple's documentation and WWDC videos. I started with the documentation when implementing the frameworks, and, as a result, I've become more confident and familiar with Apple's documentation.
  - Note: to run the app a valid Open Weather API key will need to be added to two functions in the WeatherService file.


## Screenshots

<img src="https://github.com/steven-hill/Weather-app/blob/main/App%201.png?raw=true" width="275" height="575">
<img src="https://github.com/steven-hill/Weather-app/blob/main/App%202.png?raw=true" width="275" height="575">
<img src="https://github.com/steven-hill/Weather-app/blob/main/Widget%201.png?raw=true" width="275" height="575">
<img src="https://github.com/steven-hill/Weather-app/blob/main/Widget%202.png?raw=true" width="275" height="575">
