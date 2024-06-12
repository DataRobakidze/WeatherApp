//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
    @StateObject var viewModel = WeatherViewModel()
    @StateObject var locationManager = LocationManager()

    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(viewModel)
                .environmentObject(locationManager)
                .environment(\.modelContext, appContainer.mainContext)

        }
        .modelContainer(for: CityData.self)
    }
}
