//
//  EndpointType.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Alamofire
import Foundation

protocol EndpointType {
    // MARK: - Properties
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}
