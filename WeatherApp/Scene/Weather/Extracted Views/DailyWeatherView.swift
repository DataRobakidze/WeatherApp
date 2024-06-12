//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Bakar Kharabadze on 6/12/24.
//
import SwiftUI

struct DailyWeatherView: View {
    
    @Binding var forecast: [List]
    private let baseIconUrlPath: String
    
    public init(forecast: Binding<[List]>, baseIconUrlPath: String) {
        self._forecast = forecast
        self.baseIconUrlPath = baseIconUrlPath
    }
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Color.white.opacity(0.35)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .frame(width: 343, height: 379)
                    
                        .overlay(
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(forecast, id: \.dt) { weather in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(DateFormater.formatDay(dateString: weather.dtTxt))
                                                    .foregroundColor(.white)
                                                    .font(.custom("Alegreya Sans", size: 18))
                                                    .font(.headline)
                                                
                                            }
                                            .frame(width: 100, alignment: .leading)
                                            .padding(.leading, -15)
                                            
                                            Spacer()
                                            
                                            if let icon = weather.weather.first?.icon {
                                                let iconUrl = baseIconUrlPath + "\(icon).png"
                                                AsyncImage(url: URL(string: iconUrl)) { image in
                                                    image.resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 40, height: 40)
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 2) {
                                                Text("\(Int(weather.main.tempMax - 273.15))")
                                                    .font(.custom("Alegreya Sans", size: 18))
                                                    .foregroundColor(.white)
                                                    
                                                Text("°C")
                                                    .font(.custom("Alegreya Sans", size: 10))
                                                    .foregroundColor(.white)
                                                
                                                Text("\(Int(weather.main.tempMin - 273.15))")
                                                    .foregroundColor(Color.white.opacity(0.7))
                                                    .font(.custom("Alegreya Sans", size: 18))
    
                                                Text("°C")
                                                    .foregroundColor(Color.white.opacity(0.7))
                                                    .font(.custom("Alegreya Sans", size: 10))
                                            }
                                            .frame(width: 80)
                                            
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal)
                                        .cornerRadius(8)
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.top)
                            }
                        )
                }
            }
        }
    }
}

#Preview {
    let forecastMock = [List(dt: 1718200800, main: Main(temp: 293.15, feelsLike: 294.15, tempMin: 291.15, tempMax: 295.15, pressure: 1013, seaLevel: 1013, grndLevel: 1000, humidity: 80, tempKf: 0), weather: [Weather(id: 800, main: MainEnum(rawValue: "Clear") ?? .clear, description: Description(rawValue: "clear sky") ?? .clearSky, icon: "01d")], clouds: Clouds(all: 0), wind: Wind(speed: 1.5, deg: 120, gust: 2.0), visibility: 10000, pop: 0.0, sys: Sys(pod: .d), dtTxt: "2024-06-12 15:00:00")]
    
    return DailyWeatherView(forecast: .constant(forecastMock), baseIconUrlPath: "https://openweathermap.org/img/wn/")
}
