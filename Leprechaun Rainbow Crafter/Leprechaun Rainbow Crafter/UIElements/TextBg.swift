//
//  TextBg.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import SwiftUI

struct TextBg: View {
    var height: CGFloat
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Image(.textBg)
                .resizable()
                .scaledToFit()
                .frame(height: height)
            
            TextWithBorder(text: text, font: .custom(Fonts.regular.rawValue, size: textSize), textColor: .appWhite, borderColor: .appGreen, borderWidth: 1)
                .textCase(.uppercase)
                
        }
    }
}

#Preview {
    TextBg(height: 100, text: "ррр...", textSize: 32)
}
