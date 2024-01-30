//
//  Helper functions.swift
//  Weather app
//
//  Created by Steven Hill on 03/01/2024.
//

import Foundation

func updateWeatherSymbol(using id: Int) -> String {
    switch id {
    case 200...232:
        return "cloud.bolt.fill"
    case 300...321:
        return "cloud.drizzle.fill"
    case 500...531:
        return "cloud.rain.fill"
    case 600...622:
        return "cloud.snow.fill"
    case 711:
        return "smoke.fill"
    case 721:
        return "sun.haze.fill"
    case 731:
        return "sun.dust.fill"
    case 741:
        return "cloud.fog.fill"
    case 781:
        return "tornado"
    case 800:
        return "sun.max.fill"
    case 801...804:
        return "cloud.fill"
    default:
        return "cloud.fill"
    }
}

func updateAQISymbolAndText(with aqi: Int) -> [String] {
    var text = ""
    var symbol = ""
    
    switch aqi {
    case 1:
        text = "good"
        symbol = "aqi.low"
    case 2:
        text = "fair"
        symbol = "aqi.low"
    case 3:
        text = "moderate"
        symbol = "aqi.medium"
    case 4:
        text = "poor"
        symbol = "aqi.high"
    case 5:
        text = "very poor"
        symbol = "aqi.high"
    default:
        text = "unavailable"
        symbol = "aqi.low"
    }
    return [symbol, text]
}
