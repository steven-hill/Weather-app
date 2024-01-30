//
//  TempView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct TempView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
            Text("\(Int(viewModel.temp))°C")
                .font(.system(size: 75))
                .foregroundColor(Color("CustomGold"))
            
            Text("Feels like \(Int(viewModel.feelsLike))°C")
                .font(.system(size: 20))
                .foregroundColor(Color("CustomGold"))
    }
}

#Preview {
    TempView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
