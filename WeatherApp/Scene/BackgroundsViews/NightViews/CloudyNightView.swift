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
    CloudyNightView()
}
