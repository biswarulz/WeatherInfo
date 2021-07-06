//
//  WeatherListCoordinator.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

class WeatherListCoordinator: Coordinator<Void> {
    
    private var navigationController: UINavigationController
    private var viewController: WeatherListViewController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        viewController = WeatherListViewController(weatherListDataSource: WeatherListDataSource(cellViewData: []))

        super.init()
        setUp()
        setUpNavigationBar()
    }
    
    private func setUp() {
        
        let service: WeatherListService = WeatherListServiceClient()
        let viewModel = WeatherListViewModel(weatherService: service)
        viewController.delegate = self
        viewModel.viewController = viewController
        viewController.weatherListViewModel = viewModel
    }
    
    override func start() {
        super.start()
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func setUpNavigationBar() {
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension WeatherListCoordinator: WeatherListViewControllerDelegate {
    
    func didSelectCell(_ data: WeatherListInfo) {
        
        let detailCoordinator = WeatherDetailCoordinator(navigationController: navigationController, detailData: data)
        addChildCoordinator(detailCoordinator)
        detailCoordinator.start()
    }
}
