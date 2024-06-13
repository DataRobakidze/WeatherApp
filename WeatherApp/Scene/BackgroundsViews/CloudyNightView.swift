//
//  CloudyNightView.swift
//  WeatherApp
//
//  Created by Mariam Sreseli on 6/13/24.
//

import SwiftUI

struct CloudyNightView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.cloudy1, Color.cloudy2]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    ZStack {
                        Image("moon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 129, height: 133)
                            .foregroundStyle(Color.white1)
                        
                        Image("sparkle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 129, height: 133)
                            .mask(
                                Image("moon")
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


