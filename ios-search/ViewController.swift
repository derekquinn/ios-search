
import UIKit

class ViewController: UIViewController {
    
    var starshipsResponse: StarshipsResponse?
    var peopleResponse: PeopleResponse?
    var vehiclesResponse: VehiclesResponse?
    
    var starshipNames: [String] = []
    var peopleNames: [String] = []
    var vehicleNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSwapiData()
        
    }
    
    @IBAction func logValues() {
        
        print("test starships---",self.starshipNames.debugDescription)
        print("test vehicles----",self.vehicleNames.debugDescription)
        print("test people -----", self.peopleNames.debugDescription)
    }
    
    func loadSwapiData() {
        
        SwapiApiService.getStarshipResults(parameters: SwapiConstants.paramStarships, completion:{ response in
            
            self.starshipsResponse = response
            
            for i in 0...9 {
                
                self.starshipNames.append((self.starshipsResponse?.results?[i].name!)!)
            }
        })
        
        SwapiApiService.getVehicleResults(parameters: SwapiConstants.paramVehicles, completion: { response in
            
            self.vehiclesResponse = response
 
            for i in 0...9 {
                
                self.vehicleNames.append((self.vehiclesResponse?.results?[i].name!)!)
            }
        })
        
        SwapiApiService.getPeopleResults(paramaters: SwapiConstants.paramPeople, completion:   { response in
            
            self.peopleResponse = response
            
            for i in 0...9 {
                self.peopleNames.append((self.peopleResponse?.results![i].name!)!)
            }
        })
    }
}
