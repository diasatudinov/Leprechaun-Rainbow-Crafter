//
//  LevelView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 16.01.2025.
//

import SwiftUI

struct LevelView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: GameViewModel
    @State private var tappedLevel = 0
    @State private var showGame = false
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
                    
                    TextWithBorder(text: "LEVELS", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
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
            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 15:18) {
                Spacer()
                ForEach(Range(1...10)) { levelNum in
                    
                    Button {
                        if viewModel.openedLevels.contains(levelNum) {
                            tappedLevel = levelNum
                            showGame = true
                        }
                    } label: {
                        ZStack {
                            Image(viewModel.openedLevels.contains(levelNum) ? .openLevel : .closeLevel)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 75:40)
                            
                            TextWithBorder(text: "\(levelNum)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                .textCase(.uppercase)
                            
                        }
                    }.offset(y: offsetCorrection(number: levelNum))
                }
                
            }
        }.background(
            Image(.levelBg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
        .fullScreenCover(isPresented: $showGame) {
            StartView(viewModel: viewModel, currentLevel: $tappedLevel)
        }
    }
    
    func offsetCorrection(number: Int) -> CGFloat {
        var offset = 0.0
        switch number {
        case 1: offset = 150
        case 2: offset = 60
        case 3: offset = 30
        case 4: offset = 60
        case 5: offset = 30
        case 6: offset = 0
        case 7: offset = -20
        case 8: offset = -110
        case 9: offset = -135
        case 10: offset = -150
        default:
            return offset
        }
        
        return DeviceInfo.shared.deviceType == .pad ? offset*2:offset
    }
}

#Preview {
    LevelView(viewModel: GameViewModel())
}
