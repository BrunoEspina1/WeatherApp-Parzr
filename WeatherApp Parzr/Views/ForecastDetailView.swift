//
//  ForecastDetailView.swift
//  WeatherApp Parzr
//
//  Created by Bruno Espina on 21/01/26.
//

import Foundation
import SwiftUI

struct ForecastDetailView: View {
    let forecast: ForecastItem

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                // TEMPERATURA ---
                VStack(alignment: .trailing, spacing: -5) {
                    Text("\(forecast.temperatureFarenheit)°")
                        .font(.system(size: 100, weight: .thin))
                        .foregroundColor(.primary)
                    
                    Text("Feels Like: \(forecast.feelsLikeFarenheit)°")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
                .padding(.top, 50)

                // CLIMA E ICONO ---
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(forecast.weather.first?.main ?? "")
                            .font(.system(size: 45, weight: .bold))
                        
                        Spacer()
                        
                        if let iconCode = forecast.weather.first?.icon {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                    
                    Text(forecast.weather.first?.description.capitalized ?? "")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 40)

                HStack(spacing: 20) {
                    InfoCard(title: "Humidity", value: "\(forecast.main.humidity)%")
                    InfoCard(title: "Wind", value: "\(Int(forecast.wind.speed)) mph")
                }
                .padding(.top, 20)

                Spacer()
            }
        }
        .navigationTitle(forecast.dateFormatted)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .bold()
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
