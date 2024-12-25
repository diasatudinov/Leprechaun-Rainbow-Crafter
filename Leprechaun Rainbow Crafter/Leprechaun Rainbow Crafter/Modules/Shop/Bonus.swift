//
//  Bonus.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.

import SwiftUI

struct Bonus : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let price: Int
    let bonus: Int
}
