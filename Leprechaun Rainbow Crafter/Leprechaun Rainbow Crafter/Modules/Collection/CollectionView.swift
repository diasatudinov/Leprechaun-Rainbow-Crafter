//
//  CollectionView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//

import SwiftUI

struct CollectionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: CollectionViewModel
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
                    
                    TextWithBorder(text: "Collections", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
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
                
                ZStack {
                    Image(.collectionBg)
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        HStack {
                            Image(.ach1)
                                .renderingMode(viewModel.achievement1 ? .original : .template)
                                .resizable()
                                .foregroundColor(.black)
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 240 : 120)
                            
                            Image(.ach2)
                                .renderingMode(viewModel.achievement2 ? .original : .template)
                                .resizable()
                                .foregroundColor(.black)
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 240 : 120)
                            
                            Image(.ach3)
                                .renderingMode(viewModel.achievement3 ? .original : .template)
                                .resizable()
                                .foregroundColor(.black)
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 240 : 120)
                            
                            Image(.ach4)
                                .renderingMode(viewModel.achievement4 ? .original : .template)
                                .resizable()
                                .foregroundColor(.black)
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 240 : 120)
                            
                        }
                    }
                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 340:170)
                
                Spacer()
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
    CollectionView(viewModel: CollectionViewModel())
}
