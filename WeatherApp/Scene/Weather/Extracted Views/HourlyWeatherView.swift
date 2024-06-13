//
////
////  HourlyWeatherView.swift
////  WeatherApp
////
////  Created by Bakar Kharabadze on 6/12/24.
////
//

import SwiftUI

struct HourlyWeatherItemView: View {
    let weather: DailyCurrent
    let baseIconUrlPath: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("\(Int(weather.temp ?? 10))°C")
                .foregroundColor(.white)
                .font(.custom("SF Pro Display", size: 16))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
            
            if let icon = weather.weather?.first?.icon {
                let iconUrl = baseIconUrlPath + "\(icon).png"
                AsyncImage(url: URL(string: iconUrl)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(DateFormater.formatTime(date: Date(timeIntervalSince1970: TimeInterval(weather.dt ?? 0))))
                .foregroundColor(.white)
                .font(.custom("SF Pro Display", size: 14))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: -2, y: 3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? Color("TapColor") : Color.clear)
        )
        .onTapGesture {
            onTap()
        }
    }
}

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
                Color(hex: "5882C1").opacity(0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                
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
                        HStack(spacing: 20) {
                            ForEach(hourly.prefix(24), id: \.dt) { weather in
                                HourlyWeatherItemView(
                                    weather: weather,
                                    baseIconUrlPath: baseIconUrlPath,
                                    isSelected: selectedTime == weather.dt,
                                    onTap: {
                                        if selectedTime == weather.dt {
                                            selectedTime = nil
                                        } else {
                                            selectedTime = weather.dt
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 40)
                    }
                }
            }
            .frame(width: screenWidth * 0.93, height: 217)
        }
    }
}
