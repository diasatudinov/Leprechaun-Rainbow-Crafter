//
//  AchievementsViewModel.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//


import SwiftUI

class CollectionViewModel: ObservableObject {
    @AppStorage("Achievement1") var achievement1: Bool = false
    @AppStorage("Achievement2") var achievement2: Bool = false
    @AppStorage("Achievement3") var achievement3: Bool = false
    @AppStorage("Achievement4") var achievement4: Bool = false
    @AppStorage("Achievement5") var achievement5: Bool = false
    @AppStorage("Achievement6") var achievement6: Bool = false
    
    func achievement1Done() {
        achievement1 = true
    }
    
    func achievement2Done() {
        achievement2 = true
    }
    
    func achievement3Done() {
        achievement3 = true
    }
    
    func achievement4Done() {
        achievement4 = true
    }
    
    func achievement5Done() {
        achievement5 = true
    }
    
    func achievement6Done() {
        achievement6 = true
    }
}
