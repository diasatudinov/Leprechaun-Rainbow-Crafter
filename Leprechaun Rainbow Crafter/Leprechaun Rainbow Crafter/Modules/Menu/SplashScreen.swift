//
//  SplashScreen.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    
                    Spacer()
                    
                }
                Spacer()
                
                
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    // Grayscale image
                    Image("logoLRC")
                        .resizable()
                        .scaledToFit()
                        .colorMultiply(.gray)
                    
                    // Color overlay with mask
                    Image("logoLRC")
                        .resizable()
                        .scaledToFit()
                        .mask(
                            Rectangle()
                                .frame(height: progress * 200) // Adjust height based on progress
                                .padding(.bottom, (1 - progress) * 200) // Align at the bottom
                        )
                }
                            .frame(height: 200)
                TextWithBorder(text: "LOADING...", font: .custom(Fonts.regular.rawValue, size: 50), textColor: .appWhite, borderColor: .yellow, borderWidth: 1)

                    .frame(height: 51)
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                    .padding(.bottom, 15)
            }
        }.background(
            Image(.appBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += 0.01
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    SplashScreen()
}
