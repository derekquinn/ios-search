//
//  SwapiApiHelper.swift
//  ios-search
//
//  Created by derek quinn on 11/22/20.
//

import Foundation

class SwapiApiService {
    
    static let swapiBaseUrl: String = "https://swapi.dev/api/"
    static let starship: String = "starships"
    
    static func getStarshipResponse(completion: @escaping (StarshipsResponse) -> Void) {
        
        let url = swapiBaseUrl + starship
        
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response: StarshipsResponse = try JSONDecoder().decode(StarshipsResponse.self, from: data)
                completion(response)
                
            } catch {
                
                print("[ERROR] getStarshipResponse()")
                
            }
        }).resume()
    }
}
