//
//  Provider.swift
//  Weather app widgetExtension
//
//  Created by Steven Hill on 01/01/2024.
//

import WidgetKit
import CoreLocation

struct Provider: TimelineProvider {
    
    let weatherService: WeatherServiceProtocol
    let locationService: LocationServiceProtocol

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry.placeholder
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getData { (weatherResult) in
            switch weatherResult {
            case .success(let entry):
                completion(entry)
            case .failure(_):
                completion(SimpleEntry.placeholder)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        getData { (weatherResult) in
            switch weatherResult {
            case .success(let entry):
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 3600)))
                completion(timeline)
            case .failure(_):
                let entry = SimpleEntry.placeholder
                let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 600)))
                completion(timeline)
            }
        }
    }
    
    private func getData(completion: @escaping (Result<SimpleEntry, Error>) -> ()) {
        if let location = locationService.locationManager.location {
            weatherService.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { weatherResult in
                switch weatherResult {
                case .success(let receivedWeather):
                    let entry = SimpleEntry(date: Date(), widgetData: receivedWeather)
                    completion(.success(entry))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
