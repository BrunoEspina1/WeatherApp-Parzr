//
//  WeatherViewModel.swift
//  WeatherApp Parzr
//
//  Created by Bruno Espina on 21/01/26.
//

import Foundation
import Combine


@MainActor
class WeatherViewModel: ObservableObject {
    @Published var forecasts: [ForecastItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchWeather(city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await WeatherNetworkManager.shared.fetchWeather(for: city)
            forecasts = response.list
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
