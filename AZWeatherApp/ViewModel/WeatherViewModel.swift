//
//  WeatherViewModel.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import Bond
import CoreLocation

class WeatherViewModel: WeatherViewModelType {
    // MARK: - Properties
    private var useCase: WeatherUseCaseType?
    
    // MARK: - Initializer
    init() {
        useCase = WeatherUseCase()
        bindUseCase()
    }
    
    // MARK: - Output
    var generalForecast = Observable<GeneralForecast?>(nil)
    var alertMessage = Observable<AlertMessage?>(nil)

    // MARK: - Input
    func loaded() {
        useCase?.loaded()        
    }
    
    // MARK: - Binding
    func bindUseCase() {
        guard let useCase = useCase else { return }
        _ = useCase.generalForecast.dropFirst(1).observeNext { [weak self] generalForecast in
            self?.generalForecast.value = generalForecast
        }
        _ = useCase.alertMessage.dropFirst(1).observeNext { [weak self] alertMessage in
            self?.alertMessage.value = alertMessage
        }
    }
    
    // MARK: - Public
    func forecastDaysCount() -> Int {
        return Int(generalForecast.value?.timeForecasts.count ?? 0)
    }
    
    func timeForecast(at index: Int) -> TimeForecast? {
        return generalForecast.value?.timeForecasts.item(at: index)
    }
}
