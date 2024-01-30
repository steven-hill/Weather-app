//
//  NameAndDescriptionView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct NameAndDescriptionView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        Text(viewModel.name.capitalized)
            .font(.system(.largeTitle))
            .foregroundColor(Color("CustomGold"))
            .padding(.bottom)
        Text(viewModel.weatherDescription.capitaliseFirstLetterOnly)
            .font(.system(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/))
            .foregroundColor(Color("CustomGold"))
    }
}

#Preview {
    NameAndDescriptionView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
