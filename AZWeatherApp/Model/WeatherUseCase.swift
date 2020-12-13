//
//  WeatherUseCase.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import CoreLocation
import Bond
import UIKit

class WeatherUseCase: NSObject, WeatherUseCaseType {
    // MARK: - Properties
    private let manager = CLLocationManager()
    private let apiManager = APIManager.shared()
    
    // MARK: - Output
    var currentCityName = Observable<String>("")
    var generalForecast = Observable<GeneralForecast?>(nil)
    var alertMessage = Observable<AlertMessage?>(nil)

    // MARK: - Input
    func loaded() {
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.requestLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherUseCase: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            loadForecast(for: location) { (generalForecast, alertMessage) in
                self.alertMessage.value = alertMessage
                self.generalForecast.value = generalForecast
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if CLLocationManager.locationServicesEnabled() {
            self.alertMessage.value = AlertMessage(title: "Failed to find user's location".localized(), body: error.localizedDescription)
        }
    }
}

// MARK: - Private
private extension WeatherUseCase {
    func loadForecast(for location: CLLocation, handler: @escaping (_ weather: GeneralForecast?, _ message: AlertMessage?)->()) {
        let coordinates = location.coordinate
        let callType = EndpointItem.loadForecast(lat: coordinates.latitude, long: coordinates.longitude)
        apiManager.call(type: callType, handler: handler)
    }
}
