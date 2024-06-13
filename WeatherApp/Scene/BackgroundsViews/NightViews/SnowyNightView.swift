//
//  SnowyNightView.swift
//  WeatherApp
//
//  Created by Mariam Sreseli on 6/13/24.
//

import SwiftUI
import SpriteKit

struct SnowyNightView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "181D25"), Color(hex: "353D48")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            SmallScreenCloudAnimation()
                .foregroundStyle(Color(hex: "E5E5E5"))
            GeometryReader {_ in
                SpriteView(scene: SnowFall(),options: [.allowsTransparency])
                    .ignoresSafeArea()
            }
            MoonView()
        }
    }
}

#Preview {
    SnowyNightView()
}


