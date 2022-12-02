import Foundation

struct Location : Identifiable, Equatable, Codable {
    let id: UUID?
    let latitude: Double
    let longitude: Double
}
