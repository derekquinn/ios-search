
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SwapiApiService.getStarshipResults(parameters: SwapiConstants.paramStarships, completion:{ response in

            let starshipResponse: StarshipsResponse = response

            print("[SUCCESS] getStarshipResponse Reached ViewController, RESULTS =",starshipResponse.results?.count ?? 0)

        })

        SwapiApiService.getVehicleResults(parameters: SwapiConstants.paramVehicles, completion: { response in

            let vehicleResponse: VehiclesResponse = response

            print("[SUCCESS] getVehicleResponse Reached ViewController, RESULTS =",vehicleResponse.results?.count ?? 0)
        })

        SwapiApiService.getPeopleResults(paramaters: SwapiConstants.paramPeople, completion:   { response in

            let peopleResponse: PeopleResponse = response

            print("[SUCCESS] getPeopleResponse Reached ViewController, RESULTS =",peopleResponse.results?.count ?? 0)
        })

    }
    
}

