struct Bonus : Identifiable, Equatable, Codable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
    var purchased = false
}