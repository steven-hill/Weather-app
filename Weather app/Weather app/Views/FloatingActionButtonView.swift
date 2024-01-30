//
//  FloatingActionButtonView.swift
//  Weather app
//
//  Created by Steven Hill on 09/01/2024.
//

import SwiftUI

struct FloatingActionButtonView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button(action: {
                    viewModel.hasError = false
                    viewModel.getWeather()
                    viewModel.getAirPollution()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color("CustomGold"))
                        .foregroundColor(Color("CustomNavyBlue"))
                        .clipShape(Circle())
                        .accessibilityLabel("Refresh the weather data")
                })
                .padding()
            }
        }
    }
}

#Preview {
    FloatingActionButtonView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
