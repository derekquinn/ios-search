//
//  StarshipsResponse.swift
//  ios-search
//
//  Created by derek quinn on 11/22/20.
//

import Foundation

struct StarshipsResponse: Codable {
    
    let count: Int
    let next: String?
    let prevoius: String?
    let results: [Result]?
    
}

struct Result: Codable {
    
    let name: String?
    let model: String?
    let manufacturer: String?
    let cost_in_credits: String?
    let length: String?
    let max_atmosphering_speed: String?
    let crew: String?
    let passengers: String?
    let cargo_capacity: String?
    let consumables: String?
    let hyperdrive_rating: String?
    let MGLT: String?
    let starship_class: String?
    let pilots: [String]?
    
}
