//
//  WeatherViewController.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 12.12.2020.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: WeatherViewModelType = WeatherViewModel()
    private let rowHeight: CGFloat = 100
    
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.loaded()
        
        configureActivityIndicator()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Binding
    func bindViewModel() {
        _ = viewModel.generalForecast.dropFirst(1).observeNext { [weak self] generalForecast in
            self?.activityIndicator?.stopAnimating()
            if let generalForecast = generalForecast {
                self?.updateWeather(with: generalForecast)
            }
        }
        
        _ = viewModel.alertMessage.dropFirst(1).observeNext { [weak self] alertMessage in
            guard let self = self, let alertMessage = alertMessage else { return }
            self.activityIndicator?.stopAnimating()
            UIAlertController.alert(title: alertMessage.title, message: alertMessage.body, target: self)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.forecastDaysCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell,
              let timeForecast = viewModel.timeForecast(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(with: timeForecast)
        return cell
    }
}

// MARK: - Private
private extension WeatherViewController {
    func configureTableView() {
        forecastTableView.delegate = self
        forecastTableView.register(UINib(nibName: WeatherCell.identifier, bundle: nil), forCellReuseIdentifier: WeatherCell.identifier)
        // Removing separators for empty cells
        forecastTableView.tableFooterView = UIView()
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        guard let activityIndicator = activityIndicator else { return }
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func updateWeather(with forecast: GeneralForecast) {
        view.backgroundColor = UIColor(red: 112.0/255, green: 86.0/255, blue: 164.0/255, alpha: 1.0)
        self.forecastTableView.isHidden = false
        if let currentForecast = forecast.timeForecasts.first {
            cityName.text = "\(forecast.city.name), \(forecast.city.country)".uppercased()
            temperature.text = "\(Int(currentForecast.mainInfo.temperature.rounded()))°C"
            weatherDescription.text = (currentForecast.weather.first?.description ?? "None weather info".localized()).uppercased()
        }
        forecastTableView.reloadData()
    }
}
