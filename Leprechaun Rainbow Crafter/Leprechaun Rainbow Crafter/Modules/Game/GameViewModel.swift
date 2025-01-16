//
//  GameViewModel.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 16.01.2025.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var allIngredients: [Ingredient] = [
        Ingredient(name: "ing1", icon: "ingIcon1"),
        Ingredient(name: "ing2", icon: "ingIcon2"),
        Ingredient(name: "ing3", icon: "ingIcon3"),
        Ingredient(name: "ing4", icon: "ingIcon4"),
        Ingredient(name: "ing5", icon: "ingIcon5"),
        Ingredient(name: "ing6", icon: "ingIcon6"),
        Ingredient(name: "ing7", icon: "ingIcon7"),
        Ingredient(name: "ing8", icon: "ingIcon8"),
    ]
    
    @Published var openedLevels: [Int] = [1]
    
    func makePoison(for level: Int) -> [Ingredient] {
        guard level > 0 && level <= 10 else { return [] }
        
        var selectedIngredients: [Ingredient] = []
        var availableIngredients = allIngredients.shuffled()
        
        // Add unique ingredients based on the level
        for _ in 0..<level {
            if let ingredient = availableIngredients.popLast() {
                let randomCount = Int.random(in: 1...3)
                for _ in 0..<randomCount {
                    selectedIngredients.append(ingredient)
                }
            }
        }
        
        return selectedIngredients
    }
    
    func compareIngredients(_ array1: [Ingredient], _ array2: [Ingredient]) -> Bool {
        let sortedArray1 = array1.sorted { $0.name < $1.name }
        let sortedArray2 = array2.sorted { $0.name < $1.name }
        return sortedArray1 == sortedArray2
    }
    
    func winLevel(currentLevel: Int) {
        if currentLevel < 10, !openedLevels.contains(currentLevel + 1) {
            openedLevels.append(currentLevel + 1)
        }
    }
    
    
}

struct Ingredient : Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    
}
