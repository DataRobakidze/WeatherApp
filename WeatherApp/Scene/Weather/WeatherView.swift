//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    var body: some View {
        HourlyWeatherView(hourly: $viewModel.hourly, current: $viewModel.current, baseIconUrlPath: viewModel.baseIconUrlPath)
        DailyWeatherView(forecast: $viewModel.forecast, baseIconUrlPath: viewModel.baseIconUrlPath)
    }
}

#Preview {
    WeatherView()
        .environmentObject(WeatherViewModel())
}
