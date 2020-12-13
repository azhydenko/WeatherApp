//
//  String + Localize.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
