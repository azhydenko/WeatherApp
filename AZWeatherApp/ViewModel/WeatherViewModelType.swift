//
//  WeatherViewModelType.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import Bond

protocol WeatherViewModelType {
    // MARK: - Output
    var generalForecast: Observable<GeneralForecast?> { get set }
    var alertMessage: Observable<AlertMessage?> { get set }
    
    // MARK: - Input
    func loaded()
    
    // MARK: - Public
    func forecastDaysCount() -> Int
    func timeForecast(at index: Int) -> TimeForecast?
}
