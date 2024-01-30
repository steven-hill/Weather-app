//
//  Weather_app_widget.swift
//  Weather app widget
//
//  Created by Steven Hill on 01/01/2024.
//

import WidgetKit
import SwiftUI

struct Weather_app_widget: Widget {

    let kind: String = "Weather_app_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(weatherService: WeatherService(), locationService: LocationService())) { entry in
            if #available(iOS 17.0, *) {
                WidgetView(entry: entry)
                    .containerBackground(Color("CustomNavyBlue"), for: .widget)
            } else {
                WidgetView(entry: entry)
                    .padding()
                    .background(Color("CustomNavyBlue"))
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Weather app")
        .description("Shows the current weather at your location.")
    }
}

#Preview(as: .systemSmall) {
    Weather_app_widget()
} timeline: {
    SimpleEntry(date: .now, widgetData: SimpleEntry.placeholder.widgetData)
    SimpleEntry(date: .now, widgetData: SimpleEntry.placeholder.widgetData)
}
