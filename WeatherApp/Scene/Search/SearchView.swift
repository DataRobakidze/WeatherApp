//
//  SearchView.swift
//  WeatherApp
//
//  Created by Data on 12.06.24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchView()
        .environmentObject(WeatherViewModel())
}
