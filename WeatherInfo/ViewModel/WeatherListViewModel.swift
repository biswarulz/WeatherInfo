//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import Foundation

protocol WeatherListBusinessLogic: AnyObject {
    
    func fetchWeatherList()
    func fetchSearchedWeatherList(forCity name: String)
}

class WeatherListViewModel {
    
    let weatherService: WeatherListService
    weak var viewController: WeatherListDisplayLogic?
    private var weatherList: [WeatherListInfo] = []
    
    init(weatherService: WeatherListService) {
        
        self.weatherService = weatherService
    }
}

extension WeatherListViewModel: WeatherListBusinessLogic {
    
    func fetchWeatherList() {
        
        weatherService.fetchWeatherListFromJson { [weak self] (result) in
            
            guard let self = self else { return }
            switch result {
            case .success(let weatherInfo):
                self.weatherList = weatherInfo
                self.presentWeatherListData(weatherInfo)
            case .failure(_):
                self.presentServerError()
            }
        }
    }
    
    func fetchSearchedWeatherList(forCity name: String) {
        
        guard !name.isEmpty else {
            
            presentWeatherListData(weatherList)
            return
        }
        
        let filteredList = weatherList.filter({ $0.city.name.lowercased().contains(name) })
        presentWeatherListData(filteredList)
    }
    
}

extension WeatherListViewModel {
    
    private func presentWeatherListData(_ data: [WeatherListInfo]) {
        
        let viewData = data.map { (weatherData) -> WeatherListCellViewData in
            
            let locationName = "\(weatherData.city.name), \(weatherData.city.country)"
            let tempCelcius = "\(Int(ceil(weatherData.main.temperature - 272.5)))"
            let maxTemCelcius = "\(Int(ceil(weatherData.main.maxTemp - 272.5)))"
            let minTempCelcius = "\(Int(ceil(weatherData.main.minTemp - 272.5)))"
            let weeatherStrings = weatherData.weather.map({ $0.main })
            let weatherType = getWeatherType(weeatherStrings)
            let currentWeather = weeatherStrings.joined(separator: " / ")
            return WeatherListCellViewData(locationName: locationName, temperature: tempCelcius, minTemp: minTempCelcius, maxTemp: maxTemCelcius, currentWeather: currentWeather, weatherType: weatherType)
        }
        viewController?.displayWeatherList(withTitle: "Weather", data: viewData)
    }
    
    private func getWeatherType(_ info: [String]) -> WeatherType {
        
        if info.contains("Rain") {
            
            return .rainy
        } else if info.contains("Clouds") || info.contains("Mist") || info.contains("Haze") {
            
            return .cloudy
        } else if info.contains("Clear") {
            
            return .clear
        } else {
            
            return .none
        }
    }
    
    private func presentServerError() {
        
        viewController?.displayServerError()
    }
}
