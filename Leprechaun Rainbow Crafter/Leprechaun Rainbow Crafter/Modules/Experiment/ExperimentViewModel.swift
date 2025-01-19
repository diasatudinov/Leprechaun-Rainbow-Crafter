//
//  ExperimentViewModel.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 17.01.2025.
//

import SwiftUI

struct Poison: Hashable {
    var id = UUID()
    let name: String
    let ingredients: [Ingredient]
}

class ExperimentViewModel: ObservableObject {
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
    
    @Published var poisons: [Poison] = []
    
    init() {
        self.poisons.append(Poison(name: "Rainbow Potion", ingredients: [allIngredients[0], allIngredients[0], allIngredients[1]]))
        self.poisons.append(Poison(name: "Warmth Potion", ingredients: [allIngredients[2], allIngredients[2], allIngredients[3]]))
        self.poisons.append(Poison(name: "Silence Potion", ingredients: [allIngredients[4], allIngredients[4], allIngredients[5]]))
        self.poisons.append(Poison(name: "Dawn Potion", ingredients: [allIngredients[1], allIngredients[1], allIngredients[0]]))
        self.poisons.append(Poison(name: "Snow Potion", ingredients: [allIngredients[6], allIngredients[6], allIngredients[7]]))
    }
    
    func makePoison() -> [Ingredient] {
        var selectedIngredients: [Ingredient] = []
        var availableIngredients = allIngredients
        
        // Add unique ingredients based on the level
        if let ingredient = availableIngredients.popLast() {
            let randomCount = Int.random(in: 1...3)
            for _ in 0..<randomCount {
                selectedIngredients.append(ingredient)
            }
        }
        
        
        return selectedIngredients
    }
    
    func getPosionName(_ array1: [Ingredient]) -> String {
        let sortedArray1 = array1.sorted { $0.name < $1.name }
     
        if sortedArray1 == poisons[0].ingredients.sorted { $0.name < $1.name } {
            return poisons[0].name
        } else if sortedArray1 == poisons[1].ingredients.sorted { $0.name < $1.name } {
            return poisons[1].name
        }
        else if sortedArray1 == poisons[2].ingredients.sorted { $0.name < $1.name } {
            return poisons[2].name
        }
        else if sortedArray1 == poisons[3].ingredients.sorted { $0.name < $1.name } {
            return poisons[3].name
        }
        else if sortedArray1 == poisons[4].ingredients.sorted { $0.name < $1.name } {
            return poisons[4].name
        } else {
            return "try again"
        }
        
       // return sortedArray1 == sortedArray2
    }
    
}
