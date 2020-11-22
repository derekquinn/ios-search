
import Foundation

struct PeopleResponse: Codable {

    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]?

    struct Result: Codable {
        let name: String?
        let height: String?
        let mass: String?
        let hair_color: String?
        let skin_color: String?
        let eye_color: String?
        let birth_year: String?
        let gender: String?
        let homeworld: String?
        let films: [String]?
        let species: [String]?
        let vehicles: [String]?
        let starships: [String]?
        let created: String?
        let edited: String?
        let url: String?

    }
}
