//
//  ContentView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    @EnvironmentObject var locationAuthorisation: LocationService
    
    var body: some View {
        if locationAuthorisation.locationManager.authorizationStatus == .authorizedWhenInUse {
            ZStack {
                Color("CustomNavyBlue")
                    .ignoresSafeArea(.all)
                GeometryReader { geo in
                    VStack {
                        NameAndDescriptionView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                        SymbolView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                            .frame(width: geo.size.width, height: geo.size.height / 5)
                        TempView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                            .frame(height: geo.size.height / 12)
                        AQIView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                        ComponentGridView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                            .frame(height: geo.size.height / 3)
                    }
                }
                ZStack {
                    FloatingActionButtonView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
                }
            }
            .alert(
                Text("Uh oh, an error occurred."),
                isPresented: $viewModel.hasError,
                presenting: viewModel.errorMessage
            ) { _ in
                Button("Retry") {
                    viewModel.hasError = false
                    viewModel.isLoading = true
                    viewModel.getWeather()
                    viewModel.getAirPollution()
                }
            } message: { _ in
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
