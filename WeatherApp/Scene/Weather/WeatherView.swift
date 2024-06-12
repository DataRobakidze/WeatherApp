//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI
import CoreLocationUI
import MapKit
import SwiftData

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @Query var selectedCities: [CityData]
    
    @State private var selectedCity: CityData? = nil
    @State private var showAddLocationView = false
    
    let backgroundColor = (LinearGradient(
        colors: [Color.warmNight1, Color.warmNight2],
        startPoint: .topLeading,
        endPoint: .bottomTrailing))
    
    private var current: CurrentWeather.Main? {
        return viewModel.currentWeatherModel?.main
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    CitySelectionMenu(selectedCity: $selectedCity, selectedCities: selectedCities, selectCity: selectCity)
                    
                    ScrollView {
                        VStack(spacing: 22) {
                            CurrentTemperatureDetailsView(temperature: current?.formattedTemp ?? "", maxTemp: current?.formattedTempMax ?? "", minTemp: current?.formattedTempMin ?? "")
                                .frame(width: screenWidth * 0.93, height: 135)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            
                            CurrentDetailsHView(humidity: current?.humidity ?? 0, feelsLike: current?.formattedFeelsLike ?? "", windSpeed: viewModel.currentWeatherModel?.wind.formattedWindSpeed ?? "" )
                                .frame(width: screenWidth * 0.93, height: 47)
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            .padding()
            .background(backgroundColor)
            .onAppear {
                //Default city
                if selectedCity == nil, let defaultCity = selectedCities.first(where: { $0.name == "Tbilisi" }) {
                    selectCity(defaultCity)
                }
            }
        }
    }
    
    private func selectCity(_ city: CityData) {
        selectedCity = city
        viewModel.fetchingCurrentWeather(lat: city.latitude, lon: city.longitude)
        print(city.latitude, city.longitude)
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel())
        .environmentObject(LocationManager())
}
