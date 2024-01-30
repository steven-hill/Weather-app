//
//  WidgetView.swift
//  Weather app widgetExtension
//
//  Created by Steven Hill on 01/01/2024.
//

import WidgetKit
import SwiftUI

struct WidgetView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        HStack {
            VStack(alignment: .leading)   {
                VStack(alignment: .leading)  {
                    Text(entry.widgetData.name)
                        .padding(.bottom, 2)
                    Text(entry.widgetData.weather[0].weatherDescription.capitaliseFirstLetterOnly)
                }
                .font(.body)
                .bold()
                Spacer()
                HStack {
                    Image(systemName: updateWeatherSymbol(using: entry.widgetData.weather[0].id))
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    Text("\(Int(entry.widgetData.main.temp))°C")
                        .font(.system(.title))
                }
            }
            .minimumScaleFactor(0.8)
            .foregroundColor(Color("CustomGold"))
            
            if widgetFamily == .systemMedium {
                VStack {
                    Spacer()
                    Text("Feels like \(Int(entry.widgetData.main.feelsLike))°C")
                        .font(.system(.title3))
                        .foregroundColor(Color("CustomGold"))
                        .padding(.bottom, 10)
                }
            }
        }
    }
}
