import SwiftUI

class User: ObservableObject {
    static let shared = User()
    
    @AppStorage("coins") var storedCoins: Int = 10
    @Published var coins: Int = 10
    
    @AppStorage("game1Level") var storedLevel: Int = 1
    @Published var level: Int = 1
    
    @AppStorage("game2Level") var storedLevelGame: Int = 1
    @Published var levelGame: Int = 1
    
    init() {
        coins = storedCoins
        level = storedLevel
        levelGame = storedLevelGame
    }
    
    func updateUserCoins(for coins: Int) {
        self.coins += coins
        storedCoins = self.coins
    }
    
    func minusUserCoins(for coins: Int) {
        self.coins -= coins
        storedCoins = self.coins
    }
    
    func updateUserLevel() {
        self.level += 1
        storedLevel = self.level
    }
    
    func updateUserLevelGame2() {
        self.levelGame += 1
        storedLevelGame = self.levelGame
    }
}
