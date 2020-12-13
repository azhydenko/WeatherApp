//
//  GeneralForecast.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class GeneralForecast: Codable {
    // MARK: - Properties
    var code: String
    var message: Double
    var count: Int
    var timeForecasts: [TimeForecast]
    var city: City
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case timeForecasts = "list"
        case city
    }
        
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(Double.self, forKey: .message)
        self.count = try container.decode(Int.self, forKey: .count)
        self.city = try container.decode(City.self, forKey: .city)
        self.timeForecasts = try container.decode([TimeForecast].self, forKey: .timeForecasts).filter {
            $0.dateText.contains("00:00:00")
        }
    }
}
