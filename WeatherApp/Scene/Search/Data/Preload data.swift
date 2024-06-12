//
//  Preload data.swift
//  WeatherApp
//
//  Created by Luka Gujejiani on 12.06.24.
//

import SwiftUI
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: CityData.self)
        
        var cityFetchDescriptor = FetchDescriptor<CityData>()
        cityFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(cityFetchDescriptor).isEmpty else { return container }
        
        // This code will only run if the persistent store is empty.
        let cities = [
            CityData(city: CoordinateModel(name: "Tbilisi", latitude: 41.69, longitude: 44.80))
        ]
        
        for city in cities {
            container.mainContext.insert(city)
        }
        
        // Save the context to persist the data
        try container.mainContext.save()
        
        return container
    } catch {
        fatalError("Failed to create container: \(error)")
    }
}()
