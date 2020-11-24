
import UIKit

class ViewController: UIViewController {
    
    var starshipsResponse: StarshipsResponse?
    var peopleResponse: PeopleResponse?
    var vehiclesResponse: VehiclesResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwapiApiService.getStarshipResults(parameters: SwapiConstants.paramStarships, completion:{ response in
            
            self.starshipsResponse = response
            
            print("[SUCCESS] getStarshipResponse Reached ViewController, RESULTS =",self.starshipsResponse!.results!.count )
            
        })
        
        SwapiApiService.getVehicleResults(parameters: SwapiConstants.paramVehicles, completion: { response in
            
            self.vehiclesResponse = response
            
            print("[SUCCESS] getVehicleResponse Reached ViewController, RESULTS =",self.vehiclesResponse!.results!.count)
        })
        
        SwapiApiService.getPeopleResults(paramaters: SwapiConstants.paramPeople, completion:   { response in
            
            self.peopleResponse = response
            
            print("[SUCCESS] getPeopleResponse Reached ViewController, RESULTS =",self.peopleResponse!.results!.count)
        })
        
    }
    
    @IBAction func logValues() {
        
        print("test starships---",self.starshipsResponse?.results?.count ?? 0)
        print("test vehicles----",self.vehiclesResponse?.results?.count ?? 0)
        print("test people -----", self.peopleResponse?.results?.count ?? 0)
    }
    
}
