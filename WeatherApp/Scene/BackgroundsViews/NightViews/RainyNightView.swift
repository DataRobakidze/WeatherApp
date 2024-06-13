//
//  RainyNightView.swift
//  WeatherApp
//
//  Created by Mariam Sreseli on 6/13/24.
//

import SwiftUI
import SpriteKit

struct RainyNightView: View {
    var body: some View {
        ZStack {
          
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "050C14"), Color(hex: "2A2C2E")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            SmallScreenCloudAnimation()
            GeometryReader {_ in
                SpriteView(scene: RainFall(),options: [.allowsTransparency])
                    .ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    ZStack {
                        Image("Moon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 129, height: 133)
                            .foregroundStyle(Color.white1)
                        
                        Image("Sparkle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 129, height: 133)
                            .mask(
                                Image("Moon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 129, height: 133)
                            )
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RainyNightView()
}

