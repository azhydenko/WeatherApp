//
//  ErrorObject.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class ErrorObject: Codable {
    // MARK: - Properties
    let code: Int
    let message: String
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message = "message"
    }
        
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
}
