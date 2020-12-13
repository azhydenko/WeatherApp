//
//  UIAlertController.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import UIKit
import Foundation

extension UIAlertController {
    class func alert(title: String, message: String, target: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Exit".localized(), style: .default) { _ in
            exit(0)
        })
        target.present(alert, animated: true, completion: nil)
    }
}
