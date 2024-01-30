//
//  WeatherManager.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<APIResponse, WeatherService.FetchError>) -> Void)
    func fetchAQI(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<AirPollutionResponse, WeatherService.FetchError>) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    
    enum FetchError: Error {
        case invalidURL
        case network(Error)
        case missingResponse
        case unexpectedResponse(Int)
        case invalidData
        case invalidJSON(Error)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<APIResponse, WeatherService.FetchError>) -> Void) {
        
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=") else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                let error = FetchError.network(error!)
                completion(.failure(FetchError.network(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FetchError.missingResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(FetchError.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedData = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let receivedData = try decoder.decode(APIResponse.self, from: receivedData)
                completion(.success(receivedData))
            } catch {
                completion(.failure(FetchError.invalidJSON(error)))
            }
        }
        task.resume()
    }
    
    func fetchAQI(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<AirPollutionResponse, WeatherService.FetchError>) -> Void) {
        
        guard let aqiUrl = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=") else {
            completion(.failure(FetchError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: aqiUrl) { data, response, error in
            
            guard error == nil else {
                let error = FetchError.network(error!)
                completion(.failure(FetchError.network(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FetchError.missingResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(FetchError.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedAQIData = data else {
                completion(.failure(FetchError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let receivedAQIData = try decoder.decode(AirPollutionResponse.self, from: receivedAQIData)
                completion(.success(receivedAQIData))
                
            } catch {
                completion(.failure(FetchError.invalidJSON(error)))
            }
        }
        task.resume()
    }
}
