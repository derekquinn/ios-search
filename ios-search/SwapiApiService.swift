
import Foundation

class SwapiApiService {
    
    static func getStarshipResults(parameters: String, completion: @escaping (StarshipsResponse) -> Void) {
        
        let url = SwapiConstants.apiBaseUrl + parameters
        
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response: StarshipsResponse = try JSONDecoder().decode(StarshipsResponse.self, from: data)
                completion(response)
                print("[SUCCESS] getStarshipRespons() RESULTS: ",response.results?.count ?? 0, "URL: \(url)")
                
            } catch {
                print("[ERROR] getStarshipResponse() URL: \(url)")
            }
        }).resume()
    }
    
    static func getVehicleResults(parameters: String, completion: @escaping (VehiclesResponse) -> Void ){
        
        let url = SwapiConstants.apiBaseUrl + parameters
        
        URLSession.shared.dataTask(with: URL(string:url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response: VehiclesResponse = try JSONDecoder().decode(VehiclesResponse.self, from: data)
                completion(response)
                print("[SUCCESS] getStarshipRespons() RESULTS: ",response.results?.count ?? 0, "URL: \(url)")
                
            } catch {
                print("[ERROR] getStarshipResponse() URL: \(url)")
            }
        }).resume()
    }
}
