//
//  CloudyNightView.swift
//  WeatherApp
//
//  Created by Mariam Sreseli on 6/13/24.
//

import SwiftUI
import SpriteKit

struct CloudyNightView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "0D091A"), Color(hex: "37266E")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            AllScreenCloudAnimation()
                .foregroundStyle(Color(hex: "E5E5E5"))
            
            MoonView()
        }
    }
}

#Preview {
    CloudyNightView()
}
