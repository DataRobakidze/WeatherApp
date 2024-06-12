//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    let backgroundColor = (LinearGradient(
        colors: [Color.warmNight1, Color.warmNight2],
        startPoint: .topLeading,
        endPoint: .bottomTrailing))
    private var current: CurrentWeather.Main? {
        return viewModel.currentWeatherModel?.main
    }
    
    var body: some View {
        ZStack {
            
            //                        Image(systemName: "heart.fill")
            //                            .font(.system(size: 150))
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
//                LocationButton(.shareCurrentLocation) {
//                    locationManager.requestLocation()
//                }
            }
        }
        .padding()
        .background(backgroundColor)
        
    }
    
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel())
        .environmentObject(LocationManager())
}
