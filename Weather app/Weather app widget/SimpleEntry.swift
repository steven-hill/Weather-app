//
//  SimpleEntry.swift
//  Weather app widgetExtension
//
//  Created by Steven Hill on 01/01/2024.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let widgetData: APIResponse
}

extension SimpleEntry {
    static var placeholder: SimpleEntry {
        SimpleEntry(date: Date(), widgetData: APIResponse.init(main: APIResponse.APIMain(temp: 25, feels_like: 28, temp_min: 20, temp_max: 26, humidity: 72), weather: [APIResponse.APIWeather.init(id: 700, description: "Cloudy")], wind: APIResponse.APIWind.init(speed: 7), name: "Cupertino"))
    }
}
