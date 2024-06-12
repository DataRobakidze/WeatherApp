//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import Foundation
import NetworkService

class WeatherViewModel: ObservableObject {
  
    @Published var currentWeatherModel: CurrentWeather.Model?
    
    
    init() {
        fetchingCurrentWeather(lat: 44.34, lon: 10.99)
    }

    func fetchForecast(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=690f88717c984072f681182b5be6acb1&units=metric"
        
        NetworkService().getData(urlString: urlString) { (result: Result<Forecast.Model, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data as Any)
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchingCurrentWeather(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=690f88717c984072f681182b5be6acb1&units=metric"
        
        NetworkService().getData(urlString: urlString) { [weak self] (result: Result<CurrentWeather.Model, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.currentWeatherModel = data
                    print(data as Any)
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
