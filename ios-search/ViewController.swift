
import UIKit

class ViewController: UIViewController {
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    var searchController: UISearchController!
    // Data coming in from API & handled by Search Logic
    var currentSearchResults: [TableView] = []
    var tableViewData: [TableView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadSwapiData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewData = currentSearchResults
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = UIConstants.scopeButtonTitles
    }
    
    // Populate & Restore (reset) data in table
    func restoreDataSource() {
        currentSearchResults = tableViewData
        tableView.reloadData()
    }
    
    @IBAction func refreshData(_ sender: Any) {
        restoreDataSource()
    }
    
    // Brains of the search operation
    func filterCurrentSearchResults(searchTerm: String){
        
        if searchTerm.count > 0 {
            currentSearchResults = tableViewData
            
            let filteredResults = currentSearchResults.filter {$0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())}
            
            currentSearchResults  = filteredResults
            tableView.reloadData()
        }
    }
    
    // Make API calls to populate table view
    func loadSwapiData() {
        
        SwapiApiService.getStarshipResults(parameters: SwapiConstants.paramStarships, completion:{ response in
            
            let starshipsResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (starshipsResponse.results?[i].name)!, category: SwapiConstants.paramStarships))
            }
        })
        
        SwapiApiService.getVehicleResults(parameters: SwapiConstants.paramVehicles, completion: { response in
            
            let vehiclesResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (vehiclesResponse.results?[i].name)!, category: SwapiConstants.paramVehicles))
            }
        })
        
        SwapiApiService.getPeopleResults(paramaters: SwapiConstants.paramPeople, completion:   { response in
            
            let peopleResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (peopleResponse.results?[i].name)!, category: SwapiConstants.paramPeople))
            }
        })
    }
}

// Extensions to support search functionality
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
        cell.textLabel?.text = currentSearchResults[indexPath.row].name
        return cell
    }
}
