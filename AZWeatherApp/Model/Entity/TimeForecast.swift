//
//  Forecast.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

class TimeForecast: Codable {
    // MARK: - Properties
    var date: Int
    var mainInfo: ForecastInfo
    var weather: [WeatherDetails]
    var dateText: String
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainInfo = "main"
        case weather = "weather"
        case dateText = "dt_txt"
    }
        
    // MARK: - Initializer
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Int.self, forKey: .date)
        self.mainInfo = try container.decode(ForecastInfo.self, forKey: .mainInfo)
        self.weather = try container.decode([WeatherDetails].self, forKey: .weather)
        self.dateText = try container.decode(String.self, forKey: .dateText)
    }
}
