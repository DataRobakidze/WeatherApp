//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Bakar Kharabadze on 6/12/24.
//
import SwiftUI

struct DailyWeatherView: View {
    
    @Binding var forecast: [Forecast.List]
    private let baseIconUrlPath: String
    
    public init(forecast: Binding<[Forecast.List]>, baseIconUrlPath: String) {
        self._forecast = forecast
        self.baseIconUrlPath = baseIconUrlPath
    }
    
    var body: some View {
        VStack {
            ZStack {
                Color(hex: "5882C1").opacity(0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    .frame(width: screenWidth * 0.93, height: 379)
                
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
                                        Text("\(Int(weather.main.tempMax))")
                                            .font(.custom("Alegreya Sans", size: 18))
                                            .foregroundColor(.white)
                                            
                                        Text("°C")
                                            .font(.custom("Alegreya Sans", size: 10))
                                            .foregroundColor(.white)
                                        
                                        Text("\(Int(weather.main.tempMin))")
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


