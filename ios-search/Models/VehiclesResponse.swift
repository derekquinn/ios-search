
import Foundation

struct VehiclesResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
}

struct Result: Codable {
    let name, model, manufacturer, cost_in_credits: String?
    let length, max_atmosphering_speed, crew, passengers: String?
    let cargo_capacity, consumables, vehicle_class: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
    
}
