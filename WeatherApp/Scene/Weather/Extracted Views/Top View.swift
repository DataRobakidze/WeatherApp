//
//  Top View.swift
//  WeatherApp
//
//  Created by Luka Gujejiani on 12.06.24.
//

import SwiftUI


struct CurrentTemperatureDetailsView: View {
    @EnvironmentObject var locationManager: LocationManager

    let temperature: String
    let maxTemp: String
    let minTemp: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.35)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            
            VStack {
                
                Text("\(temperature)º")
                    .font(.system(size: 64))
                    .bold()
                
                Text("Precipitations")
                
                HStack(spacing: 15) {
                    Text("Max.: \(maxTemp)º")
                    Text("Min.: \(minTemp)º")
                }
            }
            .shadow(color: .black, radius: 5, x: 0, y: 3)
        }
    }
}

struct CurrentDetailsHView: View {
    
    let humidity: Int
    let feelsLike: String
    let windSpeed: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.35)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            
            HStack(spacing: 15) {
                
                HStack {
                    Image("HumimdityIcon")
                    Text("\(humidity)%")
                }
                
                Spacer()
                
                HStack {
                    Image("TemperatureIcon")
                    Text("\(feelsLike)%")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    Image("WindIcon")
                    Text("\(windSpeed) Km/h")
                }
            }
            .font(.system(size: 14))
            .padding(.horizontal, 30)
        }
        .foregroundStyle(.white)
    }
}

//#Preview {
//    CurrentTemperatureDetailsView()
//    CurrentTemperatureDetailsView()
//        .environmentObject(WeatherViewModel())
//    CurrentDetailsHView()
//}
