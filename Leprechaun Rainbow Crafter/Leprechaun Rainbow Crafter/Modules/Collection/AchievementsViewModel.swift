import SwiftUI

class AchievementsViewModel: ObservableObject {
    @AppStorage("AchievementOne") var achievementOne: Bool = false
    @AppStorage("AchievementTwo") var achievementTwo: Bool = false
    @AppStorage("AchievementThree") var achievementThree: Bool = false

    func achievementOneDone() {
        achievementOne = true
    }
    
    func achievementTwoDone() {
        achievementTwo = true
    }
    
    func achievementThreeDone() {
        achievementThree = true
    }
}