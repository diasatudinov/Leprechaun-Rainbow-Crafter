//
//  ExperimentView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 16.01.2025.
//

import SwiftUI
//Открывается рецепт и по нему надо собрать зелье
// рецепт можно открыть сверху в углу где то

struct ExperimentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExperimentViewModel
    @ObservedObject var collectionVM: CollectionViewModel
    
    @State private var selectedIngredients: [Ingredient] = []
    @State private var tappedIcon: String?
    @State private var showButton = true
    @State private var showPoisonsList = false
    @State private var poisons: [Poison] = []
    @State private var poisonIndex = 0
    @State private var madePotionName: String?
    
    @State private var gameOver = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Spacer()
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
                        
                        TextWithBorder(text: "Experiment", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                            .textCase(.uppercase)
                        Spacer()
                        
                        Button {
                            showPoisonsList.toggle()
                        } label: {
                            ZStack {
                                Image(systemName: "list.bullet.rectangle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.black)
                                    .background(.yellow)
                                    .cornerRadius(15)
                            }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                        }
                    }.padding([.top,.horizontal], 20)
                    
                    if !showPoisonsList {
                        HStack {
                            ZStack {
                                Image(.ingBg)
                                    .resizable()
                                    .scaledToFit()
                                VStack {
                                    ScrollView(showsIndicators: false) {
                                        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 35:15) {
                                            ForEach(viewModel.allIngredients, id: \.self) { ing in
                                                Image(ing.icon)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 50:25)
                                                    .onTapGesture {
                                                        withAnimation {
                                                            selectedIngredients.append(ing)
                                                            tappedIcon = ing.icon
                                                        }
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                            withAnimation {
                                                                showButton = false
                                                                
                                                                tappedIcon = nil
                                                            }
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }.padding(.vertical, 10)
                            }
                            Spacer()
                            
                            
                            
                            Spacer()
                            Image(.ingBg)
                                .resizable()
                                .scaledToFit()
                                .opacity(0)
                        }.padding(.horizontal, 80)
                        
                    } else {
                        Spacer()
                    }
                }
                
                VStack {
                    
                    ZStack {
                        if !showPoisonsList {
                            VStack {
                                Spacer()
                                if let tappedIcon = tappedIcon {
                                    Image(tappedIcon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                        .offset(y: 60)
                                        .transition(.opacity)
                                        .animation(.easeInOut, value: showButton)
                                } else {
                                    Image(.ingIcon1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                        .opacity(0)
                                }
                                Image(selectedIngredients.isEmpty ? .kazan: .kazanFull)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 600: 300)
                            }
                        } else {
                            VStack {
                                Spacer()
                                ZStack {
                                    Image(.bookBg)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: UIScreen.main.bounds.height / 1.3)
                                    VStack(spacing: 50) {
                                        TextWithBorder(text: "\(poisons[poisonIndex].name)", font: .custom(Fonts.regular.rawValue, size: 20), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                            .textCase(.uppercase)
                                        
                                        IngredientGridView(ingredients: poisons[poisonIndex].ingredients)
                                        
                                            .offset(y: DeviceInfo.shared.deviceType == .pad ? -60:-30)
                                        
                                        HStack {
                                            Button {
                                                if poisonIndex > 0 {
                                                    poisonIndex -= 1
                                                }
                                            } label: {
                                                TextWithBorder(text: "back", font: .custom(Fonts.regular.rawValue, size: 20), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                                    .textCase(.uppercase)
                                            }
                                            Spacer()
                                            Button {
                                                if poisonIndex < 4 {
                                                    poisonIndex += 1
                                                }
                                            } label: {
                                                TextWithBorder(text: "next", font: .custom(Fonts.regular.rawValue, size: 20), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                                    .textCase(.uppercase)
                                            }
                                        }
                                    }.frame(width: DeviceInfo.shared.deviceType == .pad ? 600:300)
                                }
                            }
                        }
                        VStack {
                            Spacer()
                            Image(.bottomBlur)
                                .resizable()
                                .scaledToFit()
                        }.allowsHitTesting(false)
                        
                    }
                    
                }.ignoresSafeArea(edges: [.bottom,.horizontal])
                
                if !showPoisonsList {
                    VStack {
                        Spacer()
                        
                        Button {
                            gameOver = true
                            madePotionName = viewModel.getPosionName(selectedIngredients)
                            if madePotionName == poisons[4].name {
                                collectionVM.achievement1Done()
                            }
                            
                            if madePotionName == poisons[3].name {
                                collectionVM.achievement2Done()
                            }
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80 :40, text: "Mix", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
                        }
                        
                        
                    }
                }
                
                if gameOver {
                    Rectangle()
                        .foregroundStyle(Color.black)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    
                    VStack {
                        
                        if let potionName = madePotionName {
                            TextWithBorder(text: potionName, font: .custom(Fonts.regular.rawValue, size: 40), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                                .textCase(.uppercase)
                        }
                        
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80 :40, text: "Return", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
                        }
                    }
                }
            }.background(
                Image(.appBg)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onAppear {
                loadPoisons()
            }
        }
    }
    
    private func loadPoisons() {
        poisons = viewModel.poisons
    }
}

#Preview {
    ExperimentView(viewModel: ExperimentViewModel(), collectionVM: CollectionViewModel())
}
