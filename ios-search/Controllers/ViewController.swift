
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
        self.setupSearchController()
        self.setupTableViewDataAndDelegate()
        
        definesPresentationContext = true
    }
    
    // Setup searchController UI style and settings
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = UIConstants.scopeButtonTitles
    }
    
    private func setupTableViewDataAndDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        tableViewData = currentSearchResults
    }
    
    // Populate & Restore (reset) data in table
    @IBAction func refreshData(_ sender: Any) {
        currentSearchResults = tableViewData
        tableView.reloadData()
    }
    
    // Brains of the search operation
   private func filterSearchController(searchBar: UISearchBar){
        
        guard let scopeString = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] else { return }
        let selectedElement = TableView.Category(rawValue: scopeString) ?? .All
        let searchText = searchBar.text ?? ""
        
        // filter tableViewData by category (scopeString) and search input (searchText)
        currentSearchResults = tableViewData.filter { tableView in
            let isElementMatching = (selectedElement == .All) || (tableView.category == selectedElement)
            let isMatchingSearchText = tableView.name.lowercased().contains(searchText.lowercased()) || searchText.lowercased().isEmpty
            return isElementMatching && isMatchingSearchText
        }
        tableView.reloadData()
    }
    
    // Make API calls to populate table view
    private func loadSwapiData() {
        
        SwapiApiService.getStarshipResults(parameters: SwapiConstants.paramStarships, completion:{ response in
            
            let starshipsResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (starshipsResponse.results?[i].name!)!, category: TableView.Category.Starships))
            }
        })
        
        SwapiApiService.getVehicleResults(parameters: SwapiConstants.paramVehicles, completion: { response in
            
            let vehiclesResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (vehiclesResponse.results?[i].name)!, category: TableView.Category.Vehicles))
            }
        })
        
        SwapiApiService.getPeopleResults(paramaters: SwapiConstants.paramPeople, completion:   { response in
            
            let peopleResponse = response
            
            for i in 0...9 {
                self.tableViewData.append(TableView(name: (peopleResponse.results?[i].name)!, category: TableView.Category.People))
            }
        })
    }
}

// Extensions to support search functionality
extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchController(searchBar: searchController.searchBar)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if searchBar.text != nil {
            filterSearchController(searchBar: searchController.searchBar)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            refreshData(self)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchController(searchBar: searchBar)
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
