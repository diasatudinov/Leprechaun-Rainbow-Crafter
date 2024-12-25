//
//  ShopViewModel.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var bonuses: [Bonus] = [
        Bonus(icon: "bonusIcon1", price: 300, bonus: 20),
        Bonus(icon: "bonusIcon2", price: 450, bonus: 30),
        Bonus(icon: "bonusIcon3", price: 575, bonus: 40)
    ] {
        didSet {
            saveBonus()
        }
    }
    
    init() {
        
        loadBonus()
    }
    private let userDefaultsBonusKey = "bonuses"
    
    func saveBonus() {
        if let encodedData = try? JSONEncoder().encode(bonuses) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBonusKey)
        }
        
    }
    
    func loadBonus() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBonusKey),
           let loadedTeam = try? JSONDecoder().decode([Bonus].self, from: savedData) {
            bonuses = loadedTeam
        } else {
            print("No saved data found")
        }
    }
    
    
    
}

