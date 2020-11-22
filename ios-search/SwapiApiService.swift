//
//  SwapiApiHelper.swift
//  ios-search
//
//  Created by derek quinn on 11/22/20.
//

import Foundation

class SwapiApiService {
 
    static func getResults(parameters: String, completion: @escaping (StarshipsResponse) -> Void) {
        
        let url = SwapiConstants.apiBaseUrl + parameters
        
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                if (parameters.contains(SwapiConstants.paramStarships)){
                    let response: StarshipsResponse = try JSONDecoder().decode(StarshipsResponse.self, from: data)
                    completion(response)
                    
                    print("[SUCCESS] getStarshipRespons() RESULTS: ",response.results?.debugDescription, "URL: \(url)")
                }
      
            } catch {
                
                print("[ERROR] getStarshipResponse() URL: \(url)")
                
            }
        }).resume()
    }
}
