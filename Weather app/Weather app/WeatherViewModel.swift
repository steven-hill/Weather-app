//
//  WeatherViewModel.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import Foundation
import CoreLocation
import WidgetKit

class WeatherViewModel: NSObject, ObservableObject {
    
    private let weatherService: WeatherServiceProtocol
    private let locationService: LocationServiceProtocol

    @Published var name: String = "Unknown"
    @Published var weatherDescription: String = "Updating"
    @Published var symbol = ""
    @Published var temp: Double = 0
    @Published var feelsLike: Double = 0
    private var aqi: Int = 1
    @Published var aqiSymbol = ""
    @Published var aqiText = ""
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    @Published var humidity: Double = 0
    @Published var tempMin: Double = 0
    @Published var tempMax: Double = 0
    @Published var speed: Double = 0
    
    init(weatherService: WeatherServiceProtocol, locationService: LocationServiceProtocol) {
        self.weatherService = weatherService
        self.locationService = locationService
        super.init()
        getWeather()
        getAirPollution() 
    }

    func getWeather() {
        isLoading = true
        self.hasError = false
        if let location = locationService.locationManager.location {
            weatherService.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] weatherResult in
                guard let self = self else { return }
                switch weatherResult {
                case .success(let receivedWeather):
                    DispatchQueue.main.async {
                        self.name = receivedWeather.name
                        self.weatherDescription = receivedWeather.weather[0].description
                        self.symbol = updateWeatherSymbol(using: receivedWeather.weather[0].id)
                        self.temp = receivedWeather.main.temp
                        self.feelsLike = receivedWeather.main.feelsLike
                        self.humidity = receivedWeather.main.humidity
                        self.tempMin = receivedWeather.main.tempMin
                        self.tempMax = receivedWeather.main.tempMax
                        self.speed = (receivedWeather.wind.speed * 3.6)
                        self.isLoading = false
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                case .failure(let error):
                    self.hasError = true
                    self.isLoading = false
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
    
    func getAirPollution() {
        isLoading = true
        self.hasError = false
        if let location = locationService.locationManager.location {
            weatherService.fetchAQI(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] AQIResult in
                guard let self = self else { return }
                switch AQIResult {
                case .success(let receivedAQIdata):
                    self.aqi = receivedAQIdata.list[0].main.aqi
                    DispatchQueue.main.async {
                        self.aqiSymbol = updateAQISymbolAndText(with: self.aqi)[0]
                        self.aqiText = updateAQISymbolAndText(with: self.aqi)[1]
                        self.isLoading = false
                    }
                case .failure(let error):
                    self.hasError = true
                    self.isLoading = false
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}
