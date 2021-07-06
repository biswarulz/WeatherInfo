//
//  WeatherDetailViewController.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 06/07/21.
//

import UIKit

protocol WeatherDetailDisplayLogic: AnyObject {
    
    func displayWeatherDetail(withTitle titleText: String, data: WeatherDetailViewData)
}

protocol WeatherDetailViewControllerDelegate: AnyObject {
    
    func viewDidClose(sender: WeatherDetailViewController)
}

class WeatherDetailViewController: UIViewController {

    lazy var sceneView: WeatherDetailView = {
        
        WeatherDetailView()
    }()
    var weatherDetailViewModel: WeatherDetailBusinessLogic?
    weak var delegate: WeatherDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tryFetchingWeatherDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        delegate?.viewDidClose(sender: self)
    }
    
    override func loadView() {
        
        view = sceneView
    }
    
    private func tryFetchingWeatherDetail() {
        
        weatherDetailViewModel?.fetchWeatherDetail()
    }
}

extension WeatherDetailViewController: WeatherDetailDisplayLogic {
    
    func displayWeatherDetail(withTitle titleText: String, data: WeatherDetailViewData) {
        
        title = titleText
        sceneView.fillData(data)
    }
    
}
