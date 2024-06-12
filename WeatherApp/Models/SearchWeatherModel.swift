//
//  SearchWeatherModel.swift
//  WeatherApp
//
//  Created by Luka Gujejiani on 12.06.24.
//

import Foundation

class SearchWeatherModel {
    struct Model: Codable {
        let weather: [Weather]
        let main: Main
    }
    
    // MARK: - Main
    struct Main: Codable {
        let temp: Double
    }

    // MARK: - Weather
    struct Weather: Codable {
        let main: String
    }
}
