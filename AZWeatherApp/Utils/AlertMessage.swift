//
//  AlertMessage.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

class AlertMessage {
    // MARK: - Properties
    public var title: String
    public var body: String
    
    // MARK: - Initializer
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
