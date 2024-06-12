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
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(viewModel)
                .environment(\.modelContext, appContainer.mainContext)
        }
        .modelContainer(for: CityData.self)
    }
}
