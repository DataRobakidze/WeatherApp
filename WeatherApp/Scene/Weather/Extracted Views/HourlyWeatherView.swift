
//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Bakar Kharabadze on 6/12/24.
//

import SwiftUI


struct HourlyWeatherView: View {
    @Binding var hourly: [DailyCurrent]
    @Binding var current: DailyCurrent?
    private let baseIconUrlPath: String
    
    @State private var selectedTime: Int? = nil
    
    public init(hourly: Binding<[DailyCurrent]>, current: Binding<DailyCurrent?>, baseIconUrlPath: String) {
        self._hourly = hourly
        self._current = current
        self.baseIconUrlPath = baseIconUrlPath
    }
    
    var body: some View {
            VStack {
                ZStack {
                    Color.white.opacity(0.35)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                        .frame(width: 343, height: 217)
                    
                    VStack {
                        HStack {
                            Text("Today")
                                .foregroundColor(.white)
                                .font(.custom("SF Pro Display", size: 20))
                                .bold()
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
                                .padding(.leading, 17)
                            
                            Spacer()
                            Text(DateFormater.formatDate(date: Date(timeIntervalSince1970: TimeInterval(current?.dt ?? 0))))
                                .foregroundColor(.white)
                                .font(.custom("SF Pro Display", size: 18))
                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
                                .padding(.trailing, 20)
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(hourly.prefix(24), id: \.dt) { weather in
                                    VStack(alignment: .center, spacing: 15) {
                                        Text("\(Int(weather.temp))°C")
                                            .foregroundColor(.white)
                                            .font(.custom("SF Pro Display", size: 16))
                                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
                                        
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
                                        
                                        Text(DateFormater.formatTime(date: Date(timeIntervalSince1970: TimeInterval(weather.dt))))
                                            .foregroundColor(.white)
                                            .font(.custom("SF Pro Display", size: 14))
                                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(selectedTime == weather.dt ? Color.black : Color.clear)
                                    )
                                    .onTapGesture {
                                        if selectedTime == weather.dt {
                                            selectedTime = nil
                                        } else {
                                            selectedTime = weather.dt
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom, 40)
                        }
                        
                    }
                }
                .frame(width: 343, height: 217)
            }
        }
    }

#Preview {
    let hourlyMock = [DailyCurrent(dt: 1718200800, sunrise: 1718163600, sunset: 1718211600, temp: 293.15, feelsLike: 294.15, pressure: 1013, humidity: 80, dewPoint: 283.15, uvi: 0.0, clouds: 40, visibility: 10000, windSpeed: 1.5, windDeg: 120, windGust: 2.0, weather: [DailyWeather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], pop: 0.0, rain: nil)]
    let currentMock = DailyCurrent(dt: 1718200800, sunrise: 1718163600, sunset: 1718211600, temp: 293.15, feelsLike: 294.15, pressure: 1013, humidity: 80, dewPoint: 283.15, uvi: 0.0, clouds: 40, visibility: 10000, windSpeed: 1.5, windDeg: 120, windGust: 2.0, weather: [DailyWeather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], pop: 0.0, rain: nil)
    
    return HourlyWeatherView(hourly: .constant(hourlyMock), current: .constant(currentMock), baseIconUrlPath: "https://openweathermap.org/img/wn/")
}
