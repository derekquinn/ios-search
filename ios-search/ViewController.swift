
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    var searchController: UISearchController!
    
    var starshipsResponse: StarshipsResponse?
    var peopleResponse: PeopleResponse?
    var vehiclesResponse: VehiclesResponse?
    
    var starshipNames: [String] = []
    var peopleNames: [String] = []
    var vehicleNames: [String] = []
    
    var currentSearchResults: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSwapiData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        starshipNames = currentSearchResults
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        
    }
    
    func filterCurrentSearchResults(searchTerm: String){
        
        if searchTerm.count > 0 {
            currentSearchResults = starshipNames
            
            let filteredResults = currentSearchResults.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())}
            
            currentSearchResults  = filteredResults
            tableView.reloadData()
        }
        
    }
    
    func restoreDataSource() {
        currentSearchResults = starshipNames
        tableView.reloadData()
    }
    
    
    
    @IBAction func refreshData(_ sender: Any) {
        restoreDataSource()
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

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterCurrentSearchResults(searchTerm: searchText)
        }
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterCurrentSearchResults(searchTerm: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            restoreDataSource()
        }
    }
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: UIConstants.selection, message: "\(UIConstants.selected)  \(currentSearchResults[indexPath.row])", preferredStyle: .alert)
        
        searchController.isActive = false
        
        let okAction = UIAlertAction(title: UIConstants.ok, style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = currentSearchResults[indexPath.row]
        return cell
    }
    
}
