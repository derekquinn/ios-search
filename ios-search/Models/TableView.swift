//
//  TableView.swift
//  ios-search
//
//  Created by derek quinn on 11/26/20.
//

import Foundation

class TableView: NSObject {
    
    var name: String
    var category:  Category
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
        super.init()
    }
    
    enum Category: String {
        case People = "People"
        case Starships = "Starships"
        case Vehicles = "Vehicles"
        case All = "All"
    }
}
