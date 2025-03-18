import Foundation

struct Space: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let images: [String]  // Updated from single image to array
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, images, rating
    }
}

struct Comment: Identifiable {
    let id: UUID
    let text: String
    let date: Date
}
