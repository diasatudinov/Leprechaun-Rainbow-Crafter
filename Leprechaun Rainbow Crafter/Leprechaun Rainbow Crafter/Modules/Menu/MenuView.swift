//
//  MenuView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showCollections = false
    @State private var showGame = false
    @State private var showShop = false
    @State private var showRules = false
    @State private var showSettings = false
    
    
    @StateObject var user = User.shared
    @StateObject var settingsVM = SettingsModel()
    @StateObject var shopVM = ShopViewModel()
    @StateObject var gameVM = GameViewModel()
    @StateObject var collectionVM = CollectionViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    ZStack {
                        
                        VStack {
                            HStack(spacing: 5){
                                Spacer()
                              
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:86)
                                    TextWithBorder(text: "\(user.coins)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 80 :30), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                                        .textCase(.uppercase)
                                        .padding(.leading, 48)
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                                Spacer()
                            }
                            Spacer()
                        }.padding()
                        
                        HStack {
                            Spacer()
                            VStack(spacing: 25) {
                                
                                
                                Button {
                                    showCollections = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Collections", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                
                                Button {
                                    showShop = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showRules = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "How to play", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showSettings = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                                Button {
                                    showGame = true
                                } label: {
                                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Start", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                }
                                
                            }
                            Spacer()
                        }
                    }
                } else {
                    ZStack {
                        
                        VStack {
                            HStack(spacing: 5){
                                Spacer()
                                ZStack {
                                    Image(.coinBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:86)
                                    TextWithBorder(text: "\(user.coins)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 80 :30), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                                        .textCase(.uppercase)
                                        .padding(.leading, 48)
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                                Spacer()
                            }.padding([.top, .trailing], 20)
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            
                            VStack(spacing: 25) {
                                Spacer()
                                
                                HStack(spacing: 25) {
                                    Spacer()
                                    Button {
                                        
                                        showCollections = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Collections", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    
                                    
                                    Button {
                                        
                                        showShop = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 25) {
                                    Spacer()
                                    Button {
                                        showRules = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "How to play", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    
                                    Button {
                                        showSettings = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                                
                                HStack(spacing: 25) {
                                    Spacer()
                                    Button {
                                        showGame = true
                                    } label: {
                                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 100 : 50, text: "START", textSize: DeviceInfo.shared.deviceType == .pad ? 40 : 24)
                                    }
                                    Spacer()
                                }
                            }.padding(.bottom, 32)
                           
                        }
                        
                        
                    }
                }
            }
            .background(
                Image(.menuBg)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
            )
            .onAppear {
                if settingsVM.musicEnabled {
                    MusicPlayer.shared.playBackgroundMusic()
                }
            }
            .onChange(of: settingsVM.musicEnabled) { enabled in
                if enabled {
                    MusicPlayer.shared.playBackgroundMusic()
                } else {
                    MusicPlayer.shared.stopBackgroundMusic()
                }
            }
            .fullScreenCover(isPresented: $showCollections) {
                CollectionView(viewModel: collectionVM)
            }
            .fullScreenCover(isPresented: $showGame) {
                LevelView(viewModel: gameVM)
            }
            .fullScreenCover(isPresented: $showShop) {
                ShopView(viewModel: shopVM)
            }
            .fullScreenCover(isPresented: $showRules) {
                RulesView()
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(settings: settingsVM)
                
            }
            
        }
    }
}

#Preview {
    MenuView()
}
