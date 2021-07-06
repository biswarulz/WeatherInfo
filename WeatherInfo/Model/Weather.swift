//
//  Weather.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 15/06/21.
//

import Foundation

struct WeatherListInfo: Decodable {
    
    let city: City
    let main: Main
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        
        case city
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try container.decodeIfPresent(City.self, forKey: .city) ?? City()
        main = try container.decodeIfPresent(Main.self, forKey: .main) ?? Main()
        weather = try container.decodeIfPresent([Weather].self, forKey: .weather) ?? []
    }
    
    init(city: City, main: Main, weather: [Weather]) {
        
        self.city = city
        self.main = main
        self.weather = weather
    }
}

struct City: Decodable {
    
    let cityId: Int
    let name: String
    let findName: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        
        case cityId = "id"
        case name
        case findName = "findname"
        case country = "country"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cityId = try container.decodeIfPresent(Int.self, forKey: .cityId) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        findName = try container.decodeIfPresent(String.self, forKey: .findName) ?? ""
        country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
    
    init(cityId: Int = 0, name: String = "", findName: String = "", country: String = "") {
        
        self.cityId = cityId
        self.name = name
        self.findName = findName
        self.country = country
    }
}

struct Main: Decodable {
    
    let temperature: Float
    let minTemp: Float
    let maxTemp: Float
    
    enum CodingKeys: String, CodingKey {
        
        case temperature = "temp"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temperature = try container.decodeIfPresent(Float.self, forKey: .temperature) ?? 0.0
        minTemp = try container.decodeIfPresent(Float.self, forKey: .minTemp) ?? 0.0
        maxTemp = try container.decodeIfPresent(Float.self, forKey: .maxTemp) ?? 0.0
    }
    
    init(temperature: Float = 0.0, minTemp: Float = 0.0, maxTemp: Float = 0.0) {
        
        self.temperature = temperature
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
}

struct Weather: Decodable {
    
    let weatherId: Int
    let main: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        
        case weatherId = "id"
        case main
        case description
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        weatherId = try container.decodeIfPresent(Int.self, forKey: .weatherId) ?? 0
        main = try container.decodeIfPresent(String.self, forKey: .main) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
    
    init(weatherId: Int = 0, main: String = "", description: String = "") {
        
        self.weatherId = weatherId
        self.main = main
        self.description = description
    }
}

enum WeatherType {
    
    case rainy
    case cloudy
    case clear
    case none
}

struct WeatherListCellViewData {
    
    let locationName: String
    let temperature: String
    let minTemp: String
    let maxTemp: String
    let currentWeather: String
    let weatherType: WeatherType
}
