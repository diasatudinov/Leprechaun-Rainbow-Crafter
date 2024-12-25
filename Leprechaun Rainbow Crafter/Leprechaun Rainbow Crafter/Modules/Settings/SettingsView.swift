//
//  SettingsView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import SwiftUI
import StoreKit

struct SettingsView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.menuBtn)
                                .resizable()
                                .scaledToFit()
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                        
                    }
                    Spacer()
                    
                    TextWithBorder(text: "Settings", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                        .textCase(.uppercase)
                    Spacer()
                    
                    ZStack {
                        Image(.menuBtn)
                            .resizable()
                            .scaledToFit()
                            .opacity(0)
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
            }.padding([.top,.horizontal], 20)

                Spacer()
            }
            
            VStack(spacing: 25) {
               
                ZStack {
                    
                    VStack(spacing: 45) {
                        Spacer()
                        HStack(spacing: 25) {
                            Button {
                                settings.musicEnabled.toggle()
                            } label: {
                                if settings.musicEnabled {
                                    Image(.musicOn)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                                } else {
                                    Image(.musicOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                                }
                            }
                            
                            Button {
                                settings.soundEnabled.toggle()
                            } label: {
                                if settings.soundEnabled {
                                    Image(.effectOn)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                                } else {
                                    Image(.effectOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                                }
                            }
                            
                        }
                        
                       
                        Button {
                            rateUs()
                        } label: {
                            ZStack {
                                Image(.textBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                                
                                TextWithBorder(text: "Rate us", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60:35), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                    .textCase(.uppercase)
                                
                            }
                        }
                        
                    }
                    
                }.scaledToFit().frame(height: DeviceInfo.shared.deviceType == .pad ? 500:312)
            }
        }.background(
            Image(.appBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView(settings: SettingsModel())
}
