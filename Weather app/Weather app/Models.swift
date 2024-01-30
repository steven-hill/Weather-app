//
//  Models.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import Foundation

struct APIResponse: Decodable {
    let main: APIMain
    let weather: [APIWeather]
    let wind: APIWind
    let name: String

struct APIMain: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct APIWeather: Decodable {
    let id: Int
    let description: String
}

struct APIWind: Decodable {
    let speed: Double
    }
}

extension APIResponse.APIWeather {
    var weatherDescription: String { return description }
}

extension APIResponse.APIMain {
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
    var feelsLike: Double { return feels_like }
}

struct AirPollutionResponse: Decodable {
    let list: [AirPollutionList]
}

struct AirPollutionList: Decodable {
    let main: AirPollutionMain
}

struct AirPollutionMain: Decodable {
    let aqi: Int
}
