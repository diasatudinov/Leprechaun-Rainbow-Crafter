//
//  ShopView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import SwiftUI

struct ShopView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ShopViewModel
    
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
                    
                    HStack(spacing: 5){
                        Spacer()
                        
                        ZStack {
                            Image(.coinBg)
                                .resizable()
                                .scaledToFit()
                            
                            Text("\(user.coins)")
                                .font(.system(size: DeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    
                
            }.padding([.top,.horizontal], 20)
                HStack {
                    
                    ForEach(viewModel.bonuses, id: \.self) { bonus in
                        itemView(image: bonus.icon, price: bonus.price, bonusCount: bonus.bonus, bonus: bonus)
                    }
                    
                    
                }
                Spacer()
            }
            
        }.background(
            Image(.appBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    @ViewBuilder func itemView(image: String, price: Int, bonusCount: Int, bonus: Bonus) -> some View {
        
        
        ZStack {
            
            Image(.shopBg)
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .center, spacing: 3) {
                
                Image(image)
                    .resizable()
                    .foregroundColor(.black)
                    .scaledToFit()
                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 250 : 140)
                    
                HStack {
                    
                    ZStack {
                        Image(.bonusBg)
                            .resizable()
                            .scaledToFit()
                        TextWithBorder(text: "\(price)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                            .textCase(.uppercase)
                            .padding(.leading, 25)
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                    
                    ZStack {
                        Image(.coinBg)
                            .resizable()
                            .scaledToFit()
                        TextWithBorder(text: "\(price)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                            .textCase(.uppercase)
                            .padding(.leading, 25)
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                    
                }
                Button {
                    
                    if user.coins > 50 {
                        user.minusUserCoins(for: 50)
                    }
                    
                } label: {
                    TextBg(height: DeviceInfo.shared.deviceType == .pad ? 75:50, text: "BUY", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
                }
                
            }
        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 450:270)
    }
}

#Preview {
    ShopView(viewModel: ShopViewModel())
}
