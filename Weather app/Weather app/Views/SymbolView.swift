//
//  SymbolView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct SymbolView: View {
    
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        Image(systemName: viewModel.symbol)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color("CustomGold"))
            .frame(width: 150, height: 150)
            .clipped()
    }
}

#Preview {
    SymbolView(viewModel: WeatherViewModel(weatherService: WeatherService(), locationService: LocationService()))
}
