//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import Foundation

class CurrentWeather: Codable {
    // MARK: - Model
    struct Model: Codable {
        let weather: [Weather]
        let base: String
        let main: Main
        let wind: Wind
        let dt: Int
        let name: String
    }

    // MARK: - Main
    struct Main: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int
        let seaLevel, grndLevel: Int?

        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
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
    struct Weather: Codable {
        let id: Int
        let main, description, icon: String
    }

    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double?

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
