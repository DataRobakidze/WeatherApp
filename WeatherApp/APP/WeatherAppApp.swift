//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(viewModel)
        }
    }
}
