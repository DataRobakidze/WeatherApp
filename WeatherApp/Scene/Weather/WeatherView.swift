//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    // MARK: Properties
    @EnvironmentObject var viewModel: WeatherViewModel
    @Query var selectedCities: [CityData]
    @State private var selectedCity: CityData? = nil
    @State private var showAddLocationView = false
    @State private var currentWeather: String? = nil
    private var current: CurrentWeather.Main? {
        viewModel.currentWeatherModel?.main
    }
    
    private var frameWidth: CGFloat {
        screenWidth * 0.93
    }
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                if let weather = viewModel.currentWeatherModel?.weather.first?.main {
                    WeatherView.changeBackgrounds(for: weather)
                }
                
                VStack {
                    
                    CitySelectionMenu(selectedCity: $selectedCity, selectedCities: selectedCities, selectCity: selectCity)
                        .padding(.trailing, 20)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: -3, y: 3)
                    
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 22) {
                            
                            CurrentTemperatureDetailsView(temperature: current?.formattedTemp ?? "", maxTemp: current?.formattedTempMax ?? "", minTemp: current?.formattedTempMin ?? "")
                                .frame(width: frameWidth, height: 135)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            
                            CurrentDetailsHView(humidity: current?.humidity ?? 0, feelsLike: current?.formattedFeelsLike ?? "", windSpeed: viewModel.currentWeatherModel?.wind.formattedWindSpeed ?? "" )
                                .frame(width: frameWidth, height: 47)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            
                            HourlyWeatherView(hourly: $viewModel.hourly, current: $viewModel.current, timeZoneOffset: $viewModel.timeZoneOffset, baseIconUrlPath: viewModel.baseIconUrlPath)
                                .frame(width: frameWidth, height: 200)
                            
                            DailyWeatherView(forecast: $viewModel.forecast, baseIconUrlPath: viewModel.baseIconUrlPath)
                                .frame(width: frameWidth, height: 363)
                        }
                    }
                }
            }
            .onAppear {
                if selectedCity == nil, let defaultCity = selectedCities.first(where: { $0.name == "Tbilisi" }) {
                    selectCity(defaultCity)
                }
            }
        }
    }
    
    // MARK: - Helper functions
    private func selectCity(_ city: CityData) {
        selectedCity = city
        viewModel.fetchingCurrentWeather(lat: city.latitude, lon: city.longitude)
        viewModel.fetchForecast(lat: city.latitude, lon: city.longitude)
        viewModel.fetchHourly(lat: city.latitude, lon: city.longitude)
    }
    
    static func changeBackgrounds(for weather: String) -> AnyView {
        switch weather {
        case "Clouds":
            return AnyView(CloudyView())
        case "Clear":
            return AnyView(SunnyView())
        case "Snow":
            return AnyView(SnowyView())
        case "Rain":
            return AnyView(RainyView())
        case "Drizzle":
            return AnyView(RainyView())
        case "Thunderstorm":
            return AnyView(RainyView())
        default:
            return AnyView(SunnyView())
        }
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel())
}
