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
    @ObservedObject var shopVM: ShopViewModel
    @State var coinsCount = 0
    @State var chestCount = 0
    @State var box2Full = false
    
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameSceneView(chestCount: $chestCount, box2Full: $box2Full, coinsCount: $coinsCount).ignoresSafeArea()
                
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Image(.bonusBg)
                                    .resizable()
                                    .scaledToFit()
                                
                                TextWithBorder(text: "\(chestCount)/\(shopVM.largestPurchasedBonus?.bonus ?? 5)", font: .custom(Fonts.regular.rawValue, size: 26), textColor: chestCount == shopVM.largestPurchasedBonus?.bonus ?? 5 ? .red : .appWhite, borderColor: chestCount == shopVM.largestPurchasedBonus?.bonus ?? 5 ? .appWhite : .appYellow, borderWidth: 1)
                                        .offset(x: 25, y: 5)
                                
                                
                            }.frame(height: 75)
                                .padding()
                            
                            ZStack {
                                Image(.coinBg)
                                    .resizable()
                                    .scaledToFit()
                                TextWithBorder(text: "\(coinsCount)", font: .custom(Fonts.regular.rawValue, size: 26), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                                    .offset(x: 25, y: 5)
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
            .onChange(of: box2Full) { newValue in
                if newValue {
                    startTimer()
                }
                
            }
            
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
    GameView(collectionVM: CollectionViewModel(), shopVM: ShopViewModel())
}
