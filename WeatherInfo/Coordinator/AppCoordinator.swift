//
//  AppCoordinator.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import UIKit

class Coordinator<CoordinationResult> {
    
    private let identifier = UUID()
    private var childCoordinators: [UUID: Coordinator] = [:]
    
    func start() {}
    
    var onFinish:((CoordinationResult) -> Void)?
    var cleanUpFromParent: ((CoordinationResult) -> Void)?
    
    func finish(_ result: CoordinationResult) {
        
        onFinish?(result)
        cleanUpFromParent?(result)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        
        coordinator.cleanUpFromParent = { [weak self] _ in
            
            guard let self = self else { return }
            
            self.removeChildCoordinator(coordinator)
        }
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator?) {
        
        guard let coordinator = coordinator else { return }
        childCoordinators[coordinator.identifier] = nil
    }
}

class AppCoordinator: Coordinator<Void> {
    
    var window: UIWindow?
    var navigationController: UINavigationController
    
    init(window: UIWindowScene) {
        
        self.window = UIWindow(windowScene: window)
        navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
    }
    
    override func start() {
        
        let albumListCoordinator = WeatherListCoordinator(navigationController: navigationController)
        albumListCoordinator.start()
        addChildCoordinator(albumListCoordinator)
        window?.makeKeyAndVisible()
    }
}
