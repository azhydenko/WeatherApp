//
//  APIManager.swift
//  AZWeatherApp
//
//  Created by Andrii Zhydenko on 13.12.2020.
//

import Alamofire
import Foundation

class APIManager {
    // MARK: - Properties
    private let session: Session
    
    private static var sharedApiManager: APIManager = {
        return APIManager(session: Session())
    }()
    
    // MARK: - Accessors
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initializer
    private init(session: Session) {
        self.session = session
    }

    // MARK: - Request
    func call<T>(type: EndpointType, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        self.session.request(type.url,
                             method: type.httpMethod,
                             parameters: params,
                             encoding: type.encoding,
                             headers: type.headers).validate().responseJSON { data in
                            switch data.result {
                            case .success(_):
                                let decoder = JSONDecoder()
                                if let jsonData = data.data {
                                    let result = try! decoder.decode(T.self, from: jsonData)
                                    handler(result, nil)
                                }
                                break
                            case .failure(_):
                                handler(nil, self.parseApiError(data: data.data))
                                break
                            }
        }
    }
}

// MARK: - Private
private extension APIManager {
    func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: "\("Error #".localized())\(error.code)", body: error.message)
        }
        return AlertMessage(title: "An error eccured".localized(), body: "Please check connection".localized())
    }
}
