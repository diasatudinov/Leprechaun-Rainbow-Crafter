//
//  GameView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//


import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var collectionVM: CollectionViewModel
    @State var valueName = "-"
    @State var achivement1 = false
    
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameSceneView(valueName: $valueName, achivement1: $achivement1).ignoresSafeArea()
                
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            ZStack {
                                
                                VStack(spacing: -7) {
                                    Text("NOW")
                                        .font(.custom(Fonts.regular.rawValue, size: 15))
                                        .foregroundStyle(.white)
                                    Text(valueName)
                                        .font(.custom(Fonts.regular.rawValue, size: 32))
                                        .foregroundStyle(.white)
                                }
                            }.frame(height: 75)
                                .padding()
                            Spacer()
                        }
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.menuBtn)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 75 : 50)
                            }
                            Spacer()
                        }.padding()
                    }
                    Spacer()
                }
                
            }
            .background(
                ZStack {
                    Image(.gameBg)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                    
                    Image(.rainbowBg)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                        .mask(
                            Rectangle()
                                .frame(width: progress * UIScreen.main.bounds.width) // Adjust height based on progress
                                .padding(.leading, (1 - progress) * UIScreen.main.bounds.width) // Align at the bottom
                        )
                }
                
            )
            .onAppear {
                //startTimer()
            }
//            .onChange(of: achivement1) { newValue in
//                if newValue {
//                    achievements.achievementOneDone()
//                }
//                
//            }
            
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
    GameView(collectionVM: CollectionViewModel())
}
