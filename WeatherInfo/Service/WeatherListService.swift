//
//  WeatherListService.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import Foundation

protocol WeatherListService {
    
    func fetchWeatherListFromJson(_ completionHandler: (Result<[WeatherListInfo], Error>) -> ())
}

class WeatherListServiceClient: WeatherListService {
    
    func fetchWeatherListFromJson(_ completionHandler: (Result<[WeatherListInfo], Error>) -> ()) {
        
        guard let bundlePath = Bundle.main.path(forResource: "weather_14", ofType: "json") else { return }
        do {
            
            let content = try String(contentsOf: URL(fileURLWithPath: bundlePath))
            
            var weatherInfo: [WeatherListInfo] = []
            if let contentData = content.data(using: .utf8) {
                
                weatherInfo = parse(jsonData: contentData)
            }
            completionHandler(.success(weatherInfo))
        } catch {
            
            let error = NSError(domain: "WeatherDOmainError", code: 101, userInfo: nil)
            completionHandler(.failure(error))
        }
        
    }
    
    private func parse(jsonData: Data) -> [WeatherListInfo] {
        do {
            let decodedData = try JSONDecoder().decode([WeatherListInfo].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        
        return []
    }
}
