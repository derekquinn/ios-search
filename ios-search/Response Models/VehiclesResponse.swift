
import Foundation

struct VehiclesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

struct Result: Codable {
    let name, model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, vehicleClass: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case costInCredits
        case length
        case maxAtmospheringSpeed
        case crew, passengers
        case cargoCapacity
        case consumables
        case vehicleClass
        case pilots, films, created, edited, url
    }
}
