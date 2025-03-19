import Foundation
import MapKit

struct Space: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let images: [String]
    let rating: Double
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, images, rating, latitude, longitude
    }
    
    // Computed property to get the CLLocationCoordinate2D
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Comment: Identifiable {
    let id: UUID
    let text: String
    let date: Date
}
