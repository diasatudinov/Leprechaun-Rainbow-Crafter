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
    let collectionVM = CollectionViewModel()
    let shopVM = ShopViewModel()
    var currentChestCountUpdateHandler: ((_ chestCount: Int) -> Void)?
    var coinsCountUpdateHandler: ((_ coinsCount: Int) -> Void)?
    var box2FullCheck: ((_ box2Full: Bool) -> Void)?
    
    
    private var basket: SKSpriteNode!
    private var chest1: SKSpriteNode!
    private var chest2: SKSpriteNode!
    private var isGameOver = false
    private var currentLevel = 1
    private var fallDuration = 5.0
    private var mistakeDone = false
    private var box1Full = false
    private var box2Full = false
    private var chestCount = 0
    private var coinsCount = 0
    private var moveToChestBtnHidden = true
    
    private var borderLabel: SKLabelNode!
    private var mainLabel: SKLabelNode!
    var maxChestVolume = 5
    
    let button = SKButton(
        imageNamed: "moveBtn", // Replace with your button image name
        size: CGSize(width: 135, height: 40)
    )
    
    override func didMove(to view: SKView) {
        setupScene()
        startLevel(currentLevel)
        maxChestVolume = shopVM.largestPurchasedBonus?.bonus ?? 5
        addButton()
    }
    
    private func showMove() {
        self.button.isHidden = false
        self.mainLabel.isHidden = false
        self.borderLabel.isHidden = false
        
    }
    
    private func removeMove() {
        self.button.isHidden = true
        self.mainLabel.isHidden = true
        self.borderLabel.isHidden = true
        
    }
    private func addButton() {
        button.position = CGPoint(x: UIScreen.main.bounds.width / 2 + 200, y: 200)
        button.isHidden = true
        button.action = {
            
            if self.chestCount == self.maxChestVolume, self.box1Full {
                print("box2Full")
                self.box2Full = true
                self.chest2.texture = SKTexture(image: UIImage(named: "fullChest2")!)
                self.box2FullCheck?(self.box2Full)
                
            }
            
            if self.chestCount == self.maxChestVolume {
                print("box1Full")
                self.box1Full = true
                self.chest1.texture = SKTexture(image: UIImage(named: "fullChest1")!)
            }
    //            self.box2Full = true
    //            self.chest2.texture = SKTexture(image: UIImage(named: "fullChest2")!)
    //            self.box2FullCheck?(self.box2Full)
            self.chestCount = 0
            self.currentChestCountUpdateHandler?(self.chestCount)
            self.removeMove()
            
        }
        addChild(button)
//        
//        // Create the label
//        let label = SKLabelNode(text: "the collected gold to the chests")
//        label.fontName = Fonts.regular.rawValue // Replace with your preferred font
//        label.fontSize = 18
//        label.fontColor = .appWhite
//        label.position = CGPoint(x: button.position.x, y: button.position.y - 40) // Position below the button
//        label.zPosition = 1 // Ensure it appears above other elements if needed
//        addChild(label)
            addBorderedLabel(text: "the collected gold\n to the chests", fontName: Fonts.regular.rawValue, fontSize: 18, fontColor: .white, borderColor: .black, position: CGPoint(x: button.position.x, y: button.position.y - 60))
        
    }

    private func addBorderedLabel(
        text: String,
        fontName: String,
        fontSize: CGFloat,
        fontColor: UIColor,
        borderColor: UIColor,
        position: CGPoint
    ) {
        // Create the main label
        mainLabel = SKLabelNode(text: text)
        mainLabel.fontName = fontName
        mainLabel.fontSize = fontSize
        mainLabel.fontColor = fontColor
        mainLabel.position = position
        mainLabel.zPosition = 1
        mainLabel.horizontalAlignmentMode = .center
        mainLabel.verticalAlignmentMode = .center
        mainLabel.numberOfLines = 0
        mainLabel.isHidden = true
        addChild(mainLabel)
        
        // Add border effect
        let offsets: [CGPoint] = [
            CGPoint(x: -2, y: 0), CGPoint(x: 2, y: 0),
            CGPoint(x: 0, y: -2), CGPoint(x: 0, y: 2),
            CGPoint(x: -2, y: -2), CGPoint(x: 2, y: 2),
            CGPoint(x: -2, y: 2), CGPoint(x: 2, y: -2)
        ]
        
        for offset in offsets {
            borderLabel = SKLabelNode(text: text)
            borderLabel.fontName = fontName
            borderLabel.fontSize = fontSize
            borderLabel.fontColor = borderColor
            borderLabel.position = CGPoint(x: position.x + offset.x, y: position.y + offset.y)
            borderLabel.zPosition = 0
            borderLabel.horizontalAlignmentMode = .center
            borderLabel.verticalAlignmentMode = .center
            borderLabel.numberOfLines = 0
            borderLabel.isHidden = true
            addChild(borderLabel)
        }
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
        // Increase the speed of falling stars
        fallDuration = max(1.0, fallDuration - 0.5) // Reduce duration with a minimum cap

        // Start spawning stars if not already running
        if !isGameOver {
            spawnChests()
        }
        
    }
    
    private func spawnChests() {
        let spawnAction = SKAction.run {
            guard !self.isGameOver else { return }
            self.createChest()
        }
        let waitAction = SKAction.wait(forDuration: 2.0) // Time between chests
        let sequenceAction = SKAction.sequence([spawnAction, waitAction])
        run(SKAction.repeatForever(sequenceAction), withKey: "spawningChests")
    }

    private func createChest() {
        // Define chest images and their probabilities
        let chestProbabilities: [(name: String, probability: Double)] = [
            ("chests1", 0.4), // 40% chance
            ("chests2", 0.4), // 40% chance
            ("chests3", 0.05), // 5% chance
            ("chests4", 0.05), // 5% chance
            ("chests5", 0.01), // 1% chance
            ("chests6", 0.01)  // 1% chance
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
        
        switch starName {
        case "chests1":
            coinsCount += 2
            User.shared.updateUserCoins(for: 2)
            collectionVM.achievement1Done()
        case "chests2":
            coinsCount += 2
            User.shared.updateUserCoins(for: 2)
            collectionVM.achievement2Done()
        case "chests3":
            coinsCount += 5
            User.shared.updateUserCoins(for: 5)
            collectionVM.achievement3Done()
        case "chests4":
            coinsCount += 5
            User.shared.updateUserCoins(for: 5)
            collectionVM.achievement4Done()
        case "chests5":
            coinsCount += 10
            User.shared.updateUserCoins(for: 10)
            collectionVM.achievement5Done()
        case "chests6":
            coinsCount += 10
            User.shared.updateUserCoins(for: 10)
            collectionVM.achievement6Done()
        default:
            ""
        }
        
        if chestCount != maxChestVolume {
            coinsCountUpdateHandler?(coinsCount)
            chestCount += 1
        }
        
        if chestCount == maxChestVolume {
            showMove()
        }
        
        currentChestCountUpdateHandler?(chestCount)
        
        if settingsVM.soundEnabled {
            playSound(named: "collect.mp3")
        }
        star.removeFromParent()
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

class SKButton: SKSpriteNode {
    var action: (() -> Void)?
    
    init(imageNamed: String, size: CGSize, action: (() -> Void)? = nil) {
        let texture = SKTexture(imageNamed: imageNamed)
        self.action = action
        super.init(texture: texture, color: .clear, size: size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.scale(to: 0.9, duration: 0.1)) // Visual feedback
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.scale(to: 1.0, duration: 0.1)) // Revert scale
        if let touch = touches.first {
            let location = touch.location(in: self.parent!)
            if self.contains(location) {
                action?()
            }
        }
    }
}
