//
//  EndpointItem.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Foundation
import KeychainSwift
import Alamofire

// MARK: - Endpoints items
enum EndpointItem {
    case loadForecast(lat: Double, long: Double)
    case otherAction // Added this useless case to create switches below. It will be useful in case of expanding
}

// MARK: - Extensions
// MARK: - EndPointType
extension EndpointItem: EndpointType {
    
    // MARK: - Properties
    var baseURL: String {
        return "http://api.openweathermap.org/data/2.5/forecast?"
    }
    
    var path: String {
        switch self {
        case .loadForecast(let lat, let long):
            let apiKey = KeychainSwift().get("apiKey") ?? ""
            let language = Locale.preferredLanguages[0] == "uk" ? "uk" : "en"
            
            return "lat=\(lat)&lon=\(long)&units=metric&lang=\(language)&appid=\(apiKey)"
        default:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loadForecast:
            return .get
        default:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest"]
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
