//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import Foundation

final class CurrentWeather: Decodable {
    // MARK: - Model
    struct Model: Decodable {
        let weather: [Weather]
        let main: Main
        let wind: Wind
    }
    
    // MARK: - Main
    struct Main: Decodable {
        let temp, feelsLike, tempMin, tempMax: Double
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
        
        var formattedTemp: String {
            return doubleInInt(temp)
        }
        
        var formattedTempMax: String {
            return doubleInInt(tempMax)
        }
        
        var formattedTempMin: String {
            return doubleInInt(tempMin)
        }
        
        var formattedFeelsLike: String {
            return doubleInInt(feelsLike)
        }
    }
    
    // MARK: - Weather
    struct Weather: Decodable {
        let main : String
    }
    
    // MARK: - Wind
    struct Wind: Decodable {
        let speed: Double
        
        var formattedWindSpeed: String {
            let speedKmh = speed * 3.6
            let roundedSpeed = Int(speedKmh.rounded())
            return String(roundedSpeed)
        }
    }
}

private func doubleInInt(_ value: Double) -> String {
    let intValue = Int(value)
    return String(intValue)
}
