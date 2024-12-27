//
//  GameSceneView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//


import SwiftUI
import SpriteKit

struct GameSceneView: UIViewRepresentable {
    @Binding var valueName: String
    @Binding var achivement1: Bool
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
//        scene.currentValueUpdateHandler = { name in
//            DispatchQueue.main.async {
//                valueName = name
//            }
//        }
//        scene.finished3rdLevel = { mistake in
//            if !mistake {
//                achivement1 = true
//            }
//        }
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .clear
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        //
    }
    

}
