//
//  Weather_appApp.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

@main
struct Weather_appApp: App {
    @StateObject var viewModel = WeatherViewModel(weatherService: WeatherService(), locationService: LocationService())
    @StateObject var locationAuthorisation = LocationService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environmentObject(locationAuthorisation)
        }
    }
}
