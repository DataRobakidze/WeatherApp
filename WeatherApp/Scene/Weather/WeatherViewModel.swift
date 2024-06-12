//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import Foundation
import NetworkService

class WeatherViewModel: ObservableObject {
    
    @Published var hourly: [DailyCurrent] = []
    @Published var forecast: [List] = []
    @Published var current: DailyCurrent?
    var baseIconUrlPath = "https://openweathermap.org/img/wn/"
    
    init() {
        fetchForecast(lat: 44.34, lon: 10.99)
        fetchingCurrentWeather(lat: 44.34, lon: 10.99)
        fetchHourly()
    }
    
    func fetchForecast(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=690f88717c984072f681182b5be6acb1"
        
        NetworkService().getData(urlString: urlString) { (result: Result<Forecast, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    var seenDays: Set<String> = []
                    var uniqueItems: [List] = []
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let outputFormatter = DateFormatter()
                    outputFormatter.dateFormat = "yyyy-MM-dd"
                    
                    for item in data.list {
                        if let date = dateFormatter.date(from: item.dtTxt) {
                            let dayString = outputFormatter.string(from: date)
                            if !seenDays.contains(dayString) {
                                seenDays.insert(dayString)
                                uniqueItems.append(item)
                            }
                        }
                    }
                    
                    self.forecast = uniqueItems
                    print(self.forecast as Any)
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchHourly() {
        let urlString = "https://openweathermap.org/data/2.5/onecall?lat=44.8015&lon=41.6938&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02"
        
        NetworkService().getData(urlString: urlString) { (result: Result<WeatherData, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.hourly = data.hourly
                    self.current = data.current
                    print(data as Any)
                case .failure(let error):
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchingCurrentWeather(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=690f88717c984072f681182b5be6acb1"
        
        NetworkService().getData(urlString: urlString) { (result: Result<CurrentWeather.Model, Error>) in
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
}
