//
//  WeatherInfoTests.swift
//  WeatherInfoTests
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import XCTest
@testable import WeatherInfo

class WeatherListViewModelTests: XCTestCase {

    private var viewModel: WeatherListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    private class WeatherListServiceSuccessSpy: WeatherListService {
        
        let weather: Weather
        init(weather: Weather) {
            
            self.weather = weather
        }
        func fetchWeatherListFromJson(_ completionHandler: (Result<[WeatherListInfo], Error>) -> ()) {
            
            let info = WeatherListInfo(city: City(cityId: 1, name: "Merida", findName: "", country: ""), main: Main(temperature: 323.0, minTemp: 323.0, maxTemp: 323.0), weather: [weather])
            completionHandler(.success([info]))
        }
    }

    private class WeatherListServiceFailureSpy: WeatherListService {
        
        func fetchWeatherListFromJson(_ completionHandler: (Result<[WeatherListInfo], Error>) -> ()) {
            
            let error = NSError(domain: "test", code: 400, userInfo: nil)
            completionHandler(.failure(error))
        }
    }
    
    private class WeatherListViewControllerSpy: WeatherListDisplayLogic {
        
        var displayWeatherListCalled = false
        var displayServerErrorCalled = false
        
        func displayWeatherList(withTitle titleText: String, data: [WeatherListCellViewData]) {
            
            displayWeatherListCalled = true
        }
        
        func displayServerError() {
            
            displayServerErrorCalled = true
        }
    }

    func testFetchWeatherSuccessListForRain() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "Rain", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherSuccessListForClouds() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "Clouds", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherSuccessListForMist() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "Mist", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherSuccessListForHaze() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "Haze", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherSuccessListForClear() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "Clear", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherSuccessListForNone() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "None", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchWeatherFailureList() {
        
        // Given
        let service = WeatherListServiceFailureSpy()
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // WHen
        viewModel.fetchWeatherList()
        
        // Then
        XCTAssertTrue(viewController.displayServerErrorCalled, "displayServerErrorCalled should be called")
    }
    
    func testFetchSearchedWeatherListForEmptyText() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "None", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // When
        viewModel.fetchSearchedWeatherList(forCity: "")
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
    
    func testFetchSearchedWeatherList() {
        
        // Given
        let service = WeatherListServiceSuccessSpy(weather: Weather(weatherId: 1, main: "None", description: ""))
        viewModel = WeatherListViewModel(weatherService: service)
        let viewController = WeatherListViewControllerSpy()
        viewModel.viewController = viewController
        
        // When
        viewModel.fetchSearchedWeatherList(forCity: "Merida")
        
        // Then
        XCTAssertTrue(viewController.displayWeatherListCalled, "displayWeatherListCalled should be called")
    }
}
