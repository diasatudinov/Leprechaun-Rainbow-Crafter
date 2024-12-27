//
//  Links.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 27.12.2024.
//


import SwiftUI

class Links {
    
    static let shared = Links()
    
    static let winStarData = "https://leprechaunrainbowcrafter.pro/chest"
    //"?page=test"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
