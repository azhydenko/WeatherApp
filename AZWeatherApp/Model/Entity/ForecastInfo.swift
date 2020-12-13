//
//  ForecastInfo.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class ForecastInfo: Codable {
    // MARK: - Properties
    var temperature: Double
    var humidity: Int
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
        
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
    }
}
