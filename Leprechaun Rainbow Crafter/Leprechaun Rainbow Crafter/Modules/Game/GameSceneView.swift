//
//  GameSceneView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//


import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    @Binding var chestCount: Int
    @Binding var box2Full: Bool
    @Binding var coinsCount: Int
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.currentChestCountUpdateHandler = { count in
            DispatchQueue.main.async {
                chestCount = count
            }
        }
        scene.box2FullCheck = { box2 in
            if box2 {
                box2Full = true
            }
        }
        scene.coinsCountUpdateHandler = { count in
            DispatchQueue.main.async {
                coinsCount = count
            }
        }
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .clear
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        //
    }
    

}
