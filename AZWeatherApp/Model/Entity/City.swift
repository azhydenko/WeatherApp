//
//  City.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class City: Codable {
    // MARK: - Properties
    var id: Int
    var name: String
    var country: String
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
    }
    
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.country = try container.decode(String.self, forKey: .country)
    }
}
