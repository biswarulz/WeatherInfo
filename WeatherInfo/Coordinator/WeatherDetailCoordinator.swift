//
//  WeatherDetailCoordinator.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 06/07/21.
//

import UIKit

class WeatherDetailCoordinator: Coordinator<Void> {
    
    private var navigationController: UINavigationController
    private var viewController: WeatherDetailViewController
    
    init(navigationController: UINavigationController, detailData: WeatherListInfo) {
        
        self.navigationController = navigationController
        viewController = WeatherDetailViewController()

        super.init()
        setUp(withData: detailData)
    }
    
    private func setUp(withData data: WeatherListInfo) {
        
        let viewModel = WeatherDetailViewModel(weatherDetailInfo: data)
        viewController.delegate = self
        viewModel.viewController = viewController
        viewController.weatherDetailViewModel = viewModel
    }
    
    override func start() {
        super.start()
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension WeatherDetailCoordinator: WeatherDetailViewControllerDelegate {
    
    func viewDidClose(sender: WeatherDetailViewController) {
        
        finish(())
    }
}
