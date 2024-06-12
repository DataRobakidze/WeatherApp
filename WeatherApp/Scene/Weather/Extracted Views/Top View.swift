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

struct CitySelectionMenu: View {
    @Binding var selectedCity: CityData?
    var selectedCities: [CityData]
    var selectCity: (CityData) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Menu {
                ForEach(selectedCities, id: \.id) { city in
                    Button(action: {
                        selectCity(city)
                    }) {
                        Text(city.name)
                        if selectedCity?.name == city.name {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                NavigationLink(destination: SearchView()) {
                    Label("Add New Location", systemImage: "plus")
                }
            } label: {
                HStack {
                    Image("Location")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.leading, 8)
                    Text(selectedCity?.name ?? "Select City")
                    Image(systemName: "chevron.down")
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(hex: "#5882C1").opacity(0.3))
                        .clipShape(
                            .rect(
                                topLeadingRadius: 20,
                                bottomLeadingRadius: 20,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0
                            )
                        )
                        .frame(height: 40)
                )
            }
        }
        .padding(.trailing, -18)
        .padding(.bottom, 40)
    }
}
//#Preview {
//    CurrentTemperatureDetailsView()
//    CurrentTemperatureDetailsView()
//        .environmentObject(WeatherViewModel())
//    CurrentDetailsHView()
//}
