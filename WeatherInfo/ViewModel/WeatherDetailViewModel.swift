//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 06/07/21.
//

import Foundation

protocol WeatherDetailBusinessLogic: AnyObject {
    
    func fetchWeatherDetail()
}

class WeatherDetailViewModel {
    
    private let weatherDetailInfo: WeatherListInfo
    weak var viewController: WeatherDetailDisplayLogic?
    
    init(weatherDetailInfo: WeatherListInfo) {
        
        self.weatherDetailInfo = weatherDetailInfo
    }
}

extension WeatherDetailViewModel: WeatherDetailBusinessLogic {
    
    func fetchWeatherDetail() {
        
        presentWeatherDetail()
    }
}

extension WeatherDetailViewModel {
    
    private func presentWeatherDetail() {
        
        let locationName = "\(weatherDetailInfo.city.name), \(weatherDetailInfo.city.country)"
        let tempCelcius = "\(Int(ceil(weatherDetailInfo.main.temperature - 272.5)))"
        let maxTemCelcius = "\(Int(ceil(weatherDetailInfo.main.maxTemp - 272.5)))"
        let minTempCelcius = "\(Int(ceil(weatherDetailInfo.main.minTemp - 272.5)))"
        let weeatherStrings = weatherDetailInfo.weather.map({ $0.main })
        let weatherType = getWeatherType(weeatherStrings)
        let currentWeather = weeatherStrings.joined(separator: " / ")
        
        let detailData = WeatherDetailViewData(locationName: locationName, temperature: tempCelcius, minTemp: minTempCelcius, maxTemp: maxTemCelcius, currentWeather: currentWeather, weatherType: weatherType, coordinates: weatherDetailInfo.city.coordinates)
        
        viewController?.displayWeatherDetail(withTitle: weatherDetailInfo.city.name, data: detailData)
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
}
