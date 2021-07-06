//
//  WeatherListViewController.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

protocol WeatherListDisplayLogic: AnyObject {
    
    func displayWeatherList(withTitle titleText: String, data: [WeatherListCellViewData])
    func displayServerError()
}

class WeatherListViewController: UIViewController {

    lazy var sceneView: WeatherListVIew = {
        
        WeatherListVIew()
    }()
    
    var weatherListViewModel: WeatherListBusinessLogic?
    let weatherListDataSource: WeatherListDataSource?
    
    init(weatherListDataSource: WeatherListDataSource) {
        
        self.weatherListDataSource = weatherListDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sceneView.tableView.dataSource = weatherListDataSource
        sceneView.tableView.delegate = self
        setupSearchField()

        tryFetchingWeatherListData()
    }
    
    override func loadView() {
        
        view = sceneView
    }
    
    private func setupSearchField() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func tryFetchingWeatherListData() {
        
        weatherListViewModel?.fetchWeatherList()
    }

}

// MARK: - WeatherListDisplayLogic delegate

extension WeatherListViewController: WeatherListDisplayLogic {
    
    func displayWeatherList(withTitle titleText: String, data: [WeatherListCellViewData]) {
        
        title = titleText
        weatherListDataSource?.cellViewData = data
        sceneView.tableView.reloadData()
        
        sceneView.isNoResultToBeShown = data.isEmpty ? true : false
    }
    
    func displayServerError() {
        
        let alert = UIAlertController(title: Identifiers.errorTitle, message: Identifiers.errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Identifiers.okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Tableview delegate

extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 120.0
    }
}

// MARK: - Search Result delegate

extension WeatherListViewController: UISearchResultsUpdating {
    
    /// Gets called when typing in the search textfield
    /// - Parameter searchController: search controller
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            weatherListViewModel?.fetchSearchedWeatherList(forCity: text.lowercased())
        }
    }
}
