//
//  ContentView.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentLevel = 1
    @State private var showRecipe = false
    @State private var selectedIngredients: [String] = []
    @State private var message = ""

    // Рецепты зелий
    let potions: [(name: String, recipe: [String])] = [
        ("Зелье Удачи", ["3 листа клевера", "2 золотые монеты"]),
        ("Зелье Силы", ["3 гриба", "2 золотые монеты"]),
        ("Зелье Скорости", ["3 листа клевера", "2 капли росы"]),
        ("Зелье Мудрости", ["3 гриба", "2 совиных пера"]),
        ("Зелье Счастья", ["3 лепестка розы", "2 ложки мёда"]),
        ("Зелье Невидимости", ["3 паутины", "2 чешуйки ящерицы"]),
        ("Зелье Любви", ["3 лепестка розы", "2 золотые звезды"]),
        ("Зелье Защиты", ["3 камня", "2 листа клевера"]),
        ("Зелье Лета", ["3 солнечных луча", "2 капли росы"]),
        ("Зелье Долголетия", ["3 капли росы", "2 семени дерева"])
        // Добавьте остальные рецепты
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Уровень: \(currentLevel)")
                .font(.largeTitle)

            HStack {
                Image(systemName: "leaf")
                    .resizable()
                    .frame(width: 50, height: 50)
                Image(systemName: "flame")
                    .resizable()
                    .frame(width: 50, height: 50)
            }

            Button("Старт") {
                showRecipe = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showRecipe = false
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            if showRecipe {
                Text("Рецепт: \(potions[currentLevel - 1].recipe.joined(separator: ", "))")
                    .font(.headline)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }

            Text("Выберите ингредиенты:")
                .font(.headline)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(availableIngredients, id: \..self) { ingredient in
                        Button(action: {
                            selectedIngredients.append(ingredient)
                        }) {
                            Text(ingredient)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }

            Text("Выбранные ингредиенты: \(selectedIngredients.joined(separator: ", "))")
                .padding()
                .foregroundColor(.gray)

            Button("Перемешать") {
                checkPotion()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)

            Text(message)
                .foregroundColor(.red)
        }
        .padding()
    }

    // Доступные ингредиенты (пример)
    var availableIngredients: [String] {
        ["лист клевера", "золотая монета", "гриб", "капля росы", "совиное перо", "лепесток розы", "ложка мёда", "паутина", "чешуйка ящерицы", "камень", "солнечный луч", "семя дерева"]
    }

    func checkPotion() {
        let requiredIngredients = potions[currentLevel - 1].recipe
        if Set(selectedIngredients) == Set(requiredIngredients) {
            message = "Поздравляем! Вы создали \(potions[currentLevel - 1].name)"
            if currentLevel < potions.count {
                currentLevel += 1
                selectedIngredients = []
            } else {
                message = "Вы прошли все уровни!"
            }
        } else {
            message = "Неправильный рецепт. Попробуйте снова."
            selectedIngredients = []
        }
    }
}

#Preview {
    ContentView()
}

//
//struct LeprechaunGameView: View {
//    @State private var level = 1
//    @State private var recipe: [Ingredient] = []
//    @State private var selectedIngredients: [Ingredient] = []
//    @State private var allIngredients: [Ingredient] = []
//    @State private var timeRemaining = 10
//    @State private var showSuccess = false
//    @State private var showFailure = false
//    @State private var isGameActive = false
//    @State private var timer: Timer?
//
//    var body: some View {
//        ZStack {
//            VStack {
//                Text("Level \(level)")
//                    .font(.largeTitle)
//                    .padding()
//
//                if isGameActive {
//                    Text("Time Remaining: \(timeRemaining)s")
//                        .font(.headline)
//                        .foregroundColor(.red)
//                        .padding()
//
//                    VStack {
//                        Text("Select Ingredients")
//                            .font(.title2)
//                            .padding()
//                        
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
//                            ForEach(allIngredients, id: \.self) { ingredient in
//                                Button {
//                                    selectIngredient(ingredient)
//                                } label: {
//                                    IngredientView(ingredient: ingredient, isSelected: selectedIngredients.contains(ingredient))
//                                }
//                            }
//                        }
//                    }
//
//                    Button("Mix") {
//                        mixPotion()
//                    }
//                    .font(.title)
//                    .buttonStyle(.borderedProminent)
//                    .padding()
//                } else {
//                    Text("Memorize the Recipe!")
//                        .font(.headline)
//                        .padding()
//
//                    VStack {
//                        ForEach(recipe, id: \.self) { ingredient in
//                            Text("\(ingredient.amount) x \(ingredient.name)")
//                                .font(.title2)
//                        }
//                    }
//                    .padding()
//
//                    Button("Start Level") {
//                        startLevel()
//                    }
//                    .font(.title)
//                    .buttonStyle(.borderedProminent)
//                }
//            }
//            .padding()
//            .onAppear(perform: setupGame)
//
//            if showSuccess {
//                SuccessView(level: $level, onContinue: nextLevel)
//            }
//
//            if showFailure {
//                FailureView(onRestart: restartLevel)
//            }
//        }
//        .background(Color.green.opacity(0.2).edgesIgnoringSafeArea(.all))
//    }
//
//    // MARK: - Game Logic
//    func setupGame() {
//        generateRecipe()
//    }
//
//    func generateRecipe() {
//        recipe = Ingredient.generateRecipe(for: level)
//        allIngredients = Ingredient.generateAllIngredients(level: level)
//        isGameActive = false
//        selectedIngredients = []
//        timeRemaining = 10
//    }
//
//    func startLevel() {
//        isGameActive = true
//        startTimer()
//    }
//
//    func startTimer() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            timeRemaining -= 1
//            if timeRemaining <= 0 {
//                endGame(success: false)
//            }
//        }
//    }
//
//    func selectIngredient(_ ingredient: Ingredient) {
//        guard !selectedIngredients.contains(ingredient) else { return }
//        selectedIngredients.append(ingredient)
//    }
//
//    func mixPotion() {
//        if selectedIngredients.sorted() == recipe.sorted() {
//            endGame(success: true)
//        } else {
//            endGame(success: false)
//        }
//    }
//
//    func endGame(success: Bool) {
//        timer?.invalidate()
//        if success {
//            showSuccess = true
//        } else {
//            showFailure = true
//        }
//    }
//
//    func nextLevel() {
//        level += 1
//        showSuccess = false
//        generateRecipe()
//    }
//
//    func restartLevel() {
//        showFailure = false
//        generateRecipe()
//    }
//}

//struct Ingredient: Identifiable, Hashable, Comparable {
//    let id = UUID()
//    let name: String
//    let amount: Int
//
//    static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
//        lhs.name < rhs.name
//    }
//
//    static func generateRecipe(for level: Int) -> [Ingredient] {
//        let allNames = ["Clover Leaf", "Raindrop", "Gold Dust", "Fairy Wing", "Moonlight Dew"]
//        return (1...3).map { _ in
//            let name = allNames.randomElement()!
//            let amount = Int.random(in: 1...level)
//            return Ingredient(name: name, amount: amount)
//        }
//    }
//
//    static func generateAllIngredients(level: Int) -> [Ingredient] {
//        let allNames = ["Clover Leaf", "Raindrop", "Gold Dust", "Fairy Wing", "Moonlight Dew"]
//        return allNames.map { name in
//            let amount = Int.random(in: 1...level)
//            return Ingredient(name: name, amount: amount)
//        }
//    }
//}



//struct LeprechaunGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeprechaunGameView()
//    }
//}
