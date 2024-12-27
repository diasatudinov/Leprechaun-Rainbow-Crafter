//
//  GameScene.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 26.12.2024.
//


import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let settingsVM = SettingsModel()
    var currentValueUpdateHandler: ((_ name: String) -> Void)?
    var finished3rdLevel: ((_ mistakeDone: Bool) -> Void)?
    
    private var basket: SKSpriteNode!
    private var chest1: SKSpriteNode!
    private var chest2: SKSpriteNode!
    private var sequence: [String] = [] // Хранит текущую последовательность
    private var currentSequenceIndex = 0
    private var isGameOver = false
    private var currentLevel = 1
    private var fallDuration = 5.0
    private var mistakeDone = false
    
    override func didMove(to view: SKView) {
        setupScene()
        startLevel(currentLevel)
    }
    
    private func setupScene() {
        // Добавляем фон
        backgroundColor = .clear
        
        chest1 = SKSpriteNode(imageNamed: "chest1")
        chest2 = SKSpriteNode(imageNamed: "chest2")
        
        let chestAspectRatio = chest1.size.width / chest1.size.height
        let chestNewHeight = 120.0
        let chestNewWidth = chestNewHeight * chestAspectRatio
        chest1.size = CGSize(width: chestNewWidth, height: chestNewHeight)
        chest2.size = CGSize(width: chestNewWidth, height: chestNewHeight)
        
        chest1.position = CGPoint(x: chest1.size.width / 2, y: chest1.size.height / 2)
        chest2.position = CGPoint(x: UIScreen.main.bounds.width - chest1.size.width / 2, y: chest1.size.height / 2)
        
        
        // Добавляем корзину
        //basket = SKSpriteNode(color: .brown, size: CGSize(width: 100, height: 50))
        let newTexture =  SKSpriteNode(imageNamed: "photoroom")
        basket = SKSpriteNode(imageNamed: "photoroom")
        
        // Rescale the node to match the new texture while maintaining its current size
        let aspectRatio = newTexture.size.width / newTexture.size.height
        let newHeight = 150.0
        let newWidth = newHeight * aspectRatio
        basket.size = CGSize(width: newWidth, height: newHeight)
        
        basket.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: 90)
        addChild(basket)
        addChild(chest1)
        addChild(chest2)
        // Добавляем управление
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view?.addGestureRecognizer(panGesture)
        
        mistakeDone = false
    }
    
    private func startLevel(_ level: Int) {
        print("Starting Level \(level)")

        // Set the sequence based on the level
        switch level {
        case 1:
            sequence = ["1", "2", "3", "4", "5"]
        case 2:
            sequence = ["A", "B", "C", "D", "E"]
        case 3:
            sequence = ["1", "A", "2", "B", "3", "C", "4", "D", "5", "E"]
        default:
            sequence = ["1", "2", "3", "4", "5", "A", "B", "C", "D", "E"] // Default sequence for higher levels
        }

        // Reset sequence progress
        currentSequenceIndex = 0

        // Increase the speed of falling stars
        fallDuration = max(1.0, fallDuration - 0.5) // Reduce duration with a minimum cap

        // Start spawning stars if not already running
        if !isGameOver {
            spawnChests()
        }
        currentValueUpdateHandler?("-")
        showLevelBanner(level)
        if level == 4 {
            print(mistakeDone)
            finished3rdLevel?(mistakeDone)
        }
    }
    
    private func spawnChests() {
        let spawnAction = SKAction.run {
            guard !self.isGameOver else { return }
            self.createChest()
        }
        let waitAction = SKAction.wait(forDuration: 1.0) // Time between chests
        let sequenceAction = SKAction.sequence([spawnAction, waitAction])
        run(SKAction.repeatForever(sequenceAction), withKey: "spawningChests")
    }

    private func createChest() {
        // Define chest images and their probabilities
        let chestProbabilities: [(name: String, probability: Double)] = [
            ("chests1", 0.4), // 40% chance
            ("chests2", 0.4), // 40% chance
            ("chests3", 0.1), // 10% chance
            ("chests4", 0.1), // 10% chance
            ("chests5", 0.05), // 5% chance
            ("chests6", 0.05)  // 5% chance
        ]

        // Calculate a random chest based on probabilities
        let randomValue = Double.random(in: 0...1)
        var cumulativeProbability: Double = 0
        var selectedChest: String?

        for (name, probability) in chestProbabilities {
            cumulativeProbability += probability
            if randomValue <= cumulativeProbability {
                selectedChest = name
                break
            }
        }

        guard let chestName = selectedChest else { return }

        // Create the chest sprite
        let chest = SKSpriteNode(imageNamed: chestName)
        chest.size = CGSize(width: 80, height: 80) // Adjust size as needed
        chest.name = chestName
        chest.position = CGPoint(x: CGFloat.random(in: 40...(size.width - 40)), y: size.height)

        // Add the chest to the scene
        addChild(chest)

        // Animation for falling
        let fallAction = SKAction.moveTo(y: 0, duration: fallDuration)
        let removeAction = SKAction.removeFromParent()
        chest.run(SKAction.sequence([fallAction, removeAction]))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Проверяем пересечение звезд и корзины
        for star in children where star is SKSpriteNode && star.name != nil {
            if star.frame.intersects(basket.frame) {
                handleCollectedStar(star as! SKSpriteNode)
            }
        }
    }
    
    private func handleCollectedStar(_ star: SKSpriteNode) {
        guard let starName = star.name else { return }
        
        if starName == sequence[safe: currentSequenceIndex] {
            if settingsVM.soundEnabled {
                playSound(named: "takeStar.mp3")
            }
            currentValueUpdateHandler?(starName)
            currentSequenceIndex += 1
            if currentSequenceIndex >= sequence.count {
                // Уровень завершен
                currentLevel += 1
                print("Level \(currentLevel - 1) Complete!")
                startLevel(currentLevel) // Переход к следующему уровню
            }
        } else {
            // Игрок выбрал неправильную звезду
            if settingsVM.soundEnabled {
                playSound(named: "incorrectStar.mp3")
            }
            mistakeDone = true
            currentValueUpdateHandler?("-")
            print("Wrong star collected!")
            currentSequenceIndex = 0 // Сброс последовательности
        }

        star.removeFromParent()
    }
    
    private func showLevelBanner(_ level: Int) {
        if settingsVM.soundEnabled {
            playSound(named: "newLevel.mp3")
        }
        let banner = SKLabelNode(text: "Level \(level)")
        banner.fontName = "AvenirNext-Bold"
        banner.fontSize = 40
        banner.fontColor = .white
        banner.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        banner.zPosition = 10
        addChild(banner)

        let fadeOut = SKAction.fadeOut(withDuration: 2.0)
        banner.run(fadeOut) {
            banner.removeFromParent()
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        gesture.setTranslation(.zero, in: self.view)
        
        let newPositionX = basket.position.x + translation.x
        basket.position.x = max(min(newPositionX, size.width - basket.size.width / 2), basket.size.width / 2)
    }
    
    func playSound(named name: String) {
        run(SKAction.playSoundFileNamed(name, waitForCompletion: false))
        
    }
    
}

// Helper для безопасного доступа к массиву
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
