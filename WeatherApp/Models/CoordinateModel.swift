//
//  CoordinateModel.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import Foundation

struct DetailInfoElement: Decodable {
    let name: String
    let latitude, longitude: Double
}
