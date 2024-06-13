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
        return viewModel.currentWeatherModel?.main
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
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 22) {
                            CurrentTemperatureDetailsView(temperature: current?.formattedTemp ?? "", maxTemp: current?.formattedTempMax ?? "", minTemp: current?.formattedTempMin ?? "")
                                .frame(width: screenWidth * 0.93, height: 135)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 2, opaque: true)
                                )
                            
                            CurrentDetailsHView(humidity: current?.humidity ?? 0, feelsLike: current?.formattedFeelsLike ?? "", windSpeed: viewModel.currentWeatherModel?.wind.formattedWindSpeed ?? "" )
                                .frame(width: screenWidth * 0.93, height: 47)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 4, opaque: true)
                                )
                            
                            HourlyWeatherView(hourly: $viewModel.hourly, current: $viewModel.current, timeZoneOffset: $viewModel.timeZoneOffset, baseIconUrlPath: viewModel.baseIconUrlPath)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 4, opaque: true)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                )
                                .frame(width: screenWidth * 0.93, height: 180)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 4, opaque: true)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                )
                            
                            DailyWeatherView(forecast: $viewModel.forecast, baseIconUrlPath: viewModel.baseIconUrlPath)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 4, opaque: true)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                )
                                .frame(width: screenWidth * 0.93, height: 363)
                                .background(
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 4, opaque: true)
                                )
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
