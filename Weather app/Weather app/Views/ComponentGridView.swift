//
//  ComponentGridView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct ComponentGridView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 60, verticalSpacing: 30) {
            GridRow {
                ComponentView(symbol: "thermometer", text: "High", value: (viewModel.tempMax.roundDouble() + "°C"))
                    .accessibilityLabel("Today's highest temperature is \((viewModel.tempMax.roundDouble() + "°C"))")
                
                ComponentView(symbol: "wind", text: "Wind speed", value: (viewModel.speed.roundDouble() + " km/h"))
            }
            
            GridRow {
                ComponentView(symbol: "thermometer", text: "Low", value: (viewModel.tempMin.roundDouble() + "°C"))
                    .accessibilityLabel("Today's lowest temperature is \((viewModel.tempMin.roundDouble() + "°C"))")
                
                ComponentView(symbol: "humidity", text: "Humidity", value: "\(viewModel.humidity.roundDouble())%")
            }
        }
        .foregroundColor(Color("CustomGold"))
    }
}

#Preview {
    ComponentGridView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
