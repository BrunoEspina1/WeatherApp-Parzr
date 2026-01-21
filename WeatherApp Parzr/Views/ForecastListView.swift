//
//  ForecastListView.swift
//  WeatherApp Parzr
//
//  Created by Bruno Espina on 19/01/26.
//

import Foundation
import SwiftUI

struct ForecastListView: View {
    let city: String
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            List(viewModel.forecasts) { forecast in
                NavigationLink {
                    ForecastDetailView(forecast: forecast)
                } label: {
                    VStack(alignment: .leading) {
                        Text(forecast.dateFormatted)
                        Text("\(forecast.temperatureFarenheit)°F - \(forecast.weather.first?.main ?? "")")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle(city)
        .task {
            await viewModel.fetchWeather(city: city)
        }
    }
}
