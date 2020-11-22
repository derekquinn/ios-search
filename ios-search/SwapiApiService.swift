
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
                print("[ERROR] getStarshipResponse() URL: \(url) Error= \(error)")
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
                print("[SUCCESS] getVehiclesResponse() RESULTS: ",response.results?.count ?? 0, "URL: \(url)")
                
            } catch {
                print("[ERROR] getVehiclesResponse() URL: \(url) Error= \(error)")
            }
        }).resume()
    }
    
    
    static func getPeopleResults (paramaters: String, completion: @escaping (PeopleResponse) -> Void) {
        
        let url = SwapiConstants.apiBaseUrl + paramaters
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let response: PeopleResponse = try JSONDecoder().decode(PeopleResponse.self, from: data)
                completion(response)
                print("[SUCCESS] getPeopleRespons() RESULTS: ",response.results?.count ?? 0, "URL: \(url)")
            } catch {
                
                print("[ERROR] getPeopleResponse() URL: \(url) Error= \(error)")
            }      
        }).resume()
    }
}
