//
//  ComponentView.swift
//  Weather app
//
//  Created by Steven Hill on 01/01/2024.
//

import SwiftUI

struct ComponentView: View {
    
    var symbol: String
    var text: String
    var value: String
    
    var body: some View {
        VStack {
            Image(systemName: symbol)
                .font(.title2)
                .frame(width: 30, height: 5)
            Text(value)
                .bold()
                .font(.title)
            Text(text)
                .font(.subheadline)
        }
    }
}

#Preview {
    ComponentView(symbol: "humidity", text: "Humidity", value: "92%")
}
