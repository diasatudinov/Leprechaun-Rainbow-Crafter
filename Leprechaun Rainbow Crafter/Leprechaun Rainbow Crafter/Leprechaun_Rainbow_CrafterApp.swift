//
//  Leprechaun_Rainbow_CrafterApp.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//

import SwiftUI

@main
struct Leprechaun_Rainbow_CrafterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
           
        }
    }
}
