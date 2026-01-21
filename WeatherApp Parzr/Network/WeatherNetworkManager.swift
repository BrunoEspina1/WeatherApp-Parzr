//
//  WeatherNetworkManager.swift
//  WeatherApp Parzr
//
//  Created by Bruno Espina on 19/01/26.
//

import Foundation

class WeatherNetworkManager {
    static let shared = WeatherNetworkManager()
    
    private let apiKey = "*"
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    
    private init() {}
    
    enum NetworkError: Error, LocalizedError {
        case invalidURL
        case invalidResponse
        case decodingError
        case serverError(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid response from server"
            case .decodingError:
                return "Failed to decode response"
            case .serverError(let message):
                return message
            }
        }
    }
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        // Make the request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check response status
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            // Try to decode error message from API
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                throw NetworkError.serverError(errorResponse.message)
            }
            throw NetworkError.serverError("HTTP \(httpResponse.statusCode)")
        }
        
        // Decode the response
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingError
        }
    }
}

struct ErrorResponse: Codable {
    let message: String
}
