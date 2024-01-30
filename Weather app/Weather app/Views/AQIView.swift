//
//  AQIView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct AQIView: View {
    
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        HStack {
            Image(systemName: viewModel.aqiSymbol)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .clipped()
            Text("AQI is \(viewModel.aqiText)")
                .font(.system(.title))
        }
        .foregroundColor(Color("CustomGold"))
        .padding(.top, 15)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    AQIView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
