//
//  WeatherUseCaseType.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import Bond

protocol WeatherUseCaseType {
    // MARK: - Output
    var currentCityName: Observable<String> { get set }
    var generalForecast: Observable<GeneralForecast?> { get set }
    var alertMessage: Observable<AlertMessage?> { get set }

    // MARK: - Input
    func loaded()
}
