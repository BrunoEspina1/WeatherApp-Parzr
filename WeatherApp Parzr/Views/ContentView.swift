//
//  ContentView.swift
//  WeatherApp Parzr
//
//  Created by Bruno Espina on 21/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var city = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Enter city", text: $city)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                NavigationLink {
                    ForecastListView(city: city)
                } label: {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
            }
            .navigationTitle("Weather Lookup")
        }
    }
}
