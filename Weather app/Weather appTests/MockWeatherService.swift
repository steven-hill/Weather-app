//
//  MockWeatherService.swift
//  Weather appTests
//
//  Created by Steven Hill on 15/01/2024.
//

import Foundation
@testable import Weather_app
import CoreLocation

class MockWeatherService: WeatherServiceProtocol {
    
    var weatherResult: Result<Weather_app.APIResponse, Weather_app.WeatherService.FetchError>!
    var aqiResult: Result<Weather_app.AirPollutionResponse, Weather_app.WeatherService.FetchError>!
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<Weather_app.APIResponse, Weather_app.WeatherService.FetchError>) -> Void) {
        completion(weatherResult)
    }
    
    func fetchAQI(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<Weather_app.AirPollutionResponse, Weather_app.WeatherService.FetchError>) -> Void) {
        completion(aqiResult)
    }
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func readMockWeatherJsonFile() -> APIResponse {
        guard let path = bundle.url(forResource: "WeatherJson", withExtension: "json") else {
            fatalError("Failed to load the mock weather JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(APIResponse.self, from: data)
            return decodedObject
        } catch {
            print("\(error)")
            fatalError("WeatherJson decoding failed.")
        }
    }
    
    func readMockAQIJsonFile() -> AirPollutionResponse {
        guard let path = bundle.url(forResource: "AQIJson", withExtension: "json") else {
            fatalError("Failed to load the mock AQI JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(AirPollutionResponse.self, from: data)
            return decodedObject
        } catch {
            print("\(error)")
            fatalError("AQIJson decoding failed.")
        }
    }
}
