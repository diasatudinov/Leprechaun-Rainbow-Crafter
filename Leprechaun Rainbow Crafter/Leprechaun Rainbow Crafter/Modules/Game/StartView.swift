//
//  StartView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 16.01.2025.
//

import SwiftUI

struct StartView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: GameViewModel
    
    @State private var selectedIngredients: [Ingredient] = []
    @State private var hidenPoison: [Ingredient] = []
    @State private var tappedIcon: String?
    @State private var remembering = true
    
    @State private var showButton = true
    
    @Binding var currentLevel: Int
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
                    
                    TextWithBorder(text: remembering ? "REMEMBER THE RECIPE":"Specify the products", font: .custom(Fonts.regular.rawValue, size: 42), textColor: .appWhite, borderColor: .appYellow, borderWidth: 1)
                        .textCase(.uppercase)
                    Spacer()
                    
                    ZStack {
                        Image(.menuBtn)
                            .resizable()
                            .scaledToFit()
                            .opacity(0)
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
            }.padding([.top,.horizontal], 20)
                if !remembering {
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
                                                    selectedIngredients.append(ing)
                                                    tappedIcon = ing.icon
                                                    
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
                    if !remembering {
                        VStack {
                            Spacer()
                            if let tappedIcon = tappedIcon {
                                Image(tappedIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                    .offset(y: 60)
                                    .transition(.opacity) // Optional animation
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
                                .frame(height: UIScreen.main.bounds.height / 1.3)
                        }
                    } else {
                        VStack {
                            Spacer()
                            ZStack {
                                Image(.bookBg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: UIScreen.main.bounds.height / 1.3)
                                VStack {
                                    IngredientGridView(ingredients: hidenPoison)
                                        .frame(width: DeviceInfo.shared.deviceType == .pad ? 600:300)
                                        .offset(y: DeviceInfo.shared.deviceType == .pad ? -60:-30)
                                }
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        Image(.bottomBlur)
                            .resizable()
                            .scaledToFit()
                    }
                    
                }
                    
            }.ignoresSafeArea(edges: [.bottom,.horizontal]).allowsHitTesting(false)
            
            VStack {
                Spacer()
                if !remembering {
                    Button {
                        if viewModel.compareIngredients(selectedIngredients, hidenPoison) {
                            viewModel.winLevel(currentLevel: currentLevel)
                        }
                        print(viewModel.compareIngredients(selectedIngredients, hidenPoison))
                    } label: {
                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80 :40, text: "Mix", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
                    }
                } else {
                    Button {
                        remembering = false
                    } label: {
                        TextBg(height: DeviceInfo.shared.deviceType == .pad ? 80 :40, text: "Start", textSize: DeviceInfo.shared.deviceType == .pad ? 40:20)
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
            gameStart()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                remembering = false
                
            }
        }
    }
    
    func gameStart() {
        selectedIngredients = []
        hidenPoison = viewModel.makePoison(for: currentLevel)
    }
    
    
}

#Preview {
    StartView(viewModel: GameViewModel(), currentLevel: .constant(1))
}

struct IngredientGridView: View {
    let ingredients: [Ingredient]
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        let ingredientCounts = Dictionary(ingredients.map { ($0, 1) }, uniquingKeysWith: +)
       
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(ingredientCounts.keys.sorted(by: { $0.name < $1.name }), id: \..name) { ingredient in
                HStack {
                    Image(ingredient.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 70:40)
                    TextWithBorder(text: "x\(ingredientCounts[ingredient] ?? 0)", font: .custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                        .textCase(.uppercase)
                }
            }
        }
        
    }
}
