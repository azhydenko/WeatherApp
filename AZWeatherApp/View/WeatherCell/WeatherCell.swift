//
//  WeaterCell.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import UIKit

class WeatherCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    // MARK: - Properties
    public static let identifier = "WeatherCell"

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        day.text = ""
        humidity.text = ""
        temperature.text = ""
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuring
    public func configure(with forecast: TimeForecast) {
        let timeInterval = TimeInterval(forecast.date)
        let forecastDate = Date(timeIntervalSince1970: timeInterval)
        day.text = forecastDate.dayNameOfWeek()?.capitalized
        humidity.text = "\("Humidity".localized()) \(forecast.mainInfo.humidity)%"
        temperature.text = "\(Int(forecast.mainInfo.temperature.rounded()))°C"
        selectionStyle = .none
    }
}
