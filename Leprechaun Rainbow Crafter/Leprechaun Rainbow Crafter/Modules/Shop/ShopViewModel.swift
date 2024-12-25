import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var bonuses: [Bonus] = [
        Bonus(icon: "magnet", name: "Magnet"),
        Bonus(icon: "acceleration", name: "Acceleration"),
        Bonus(icon: "shield", name: "shield")
    ] {
        didSet {
            saveBonus()
        }
    }
    
    init() {
        
        loadBonus()
    }
    private let userDefaultsBonusKey = "bonuses"
    
    func useBonus(name: String) {
        if let index = bonuses.firstIndex(where: { $0.name.lowercased() == name.lowercased() }) {
            bonuses[index].purchased = false
        }
    }
    
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
    
    func purchaseBonus(bonus: Bonus) {
        if let index = bonuses.firstIndex(where: { $0.id == bonus.id}) {
            bonuses[index].purchased = true
        }
    }
    
    
}

