//
//  WeatherDetails.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class WeatherDetails: Codable {
    // MARK: - Properties
    var id: Int
    var main: String
    var description: String
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
    }
        
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.main = try container.decode(String.self, forKey: .main)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
