//
//  RulesView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentTab: Int = 0
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
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                    
                    TextWithBorder(text: "How to play?", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                        .textCase(.uppercase)
                    Spacer()
                    
                    ZStack {
                        Image(.menuBtn)
                            .resizable()
                            .scaledToFit()
                            .opacity(0)
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                }.padding([.top,.horizontal], 20)
                Spacer()
            }
            VStack {
                
                TextWithBorder(text: "You play as a leprechaun collecting treasures falling from the sky. You need to place the treasures on the sides of the screen to build a rainbow. Each treasure you collect adds to your rainbow, and once all the spots are filled, the rainbow will be completed. Try to collect as many treasures as possible to create the brightest rainbow!", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 45:25), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                    .textCase(.uppercase)
                    .padding(10)
                    .padding(.vertical, 7)
                    .multilineTextAlignment(.center)
                    .background(
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.clear)
                                .background(
                                    Rectangle()
                                        .foregroundStyle(.rulesGreen.opacity(0.3))
                                        .blur(radius: 20)
                                    
                                )
                            
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 7)
                                .foregroundStyle(.appGreen)
                        }
                        
                    )
                    .cornerRadius(15)
                    .padding(.top)
            }
            
        }.background(
            ZStack {
                Image(.appBg)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
            
        )
    }
}

#Preview {
    RulesView()
}
