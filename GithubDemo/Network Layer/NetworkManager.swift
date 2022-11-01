//
//  Network Manager.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case NoData
    case DecodingError
    case APIError(String)
}


class NetworkManager: Session{
    // MARK: - Properties
    static let sharedInstance: NetworkManager = NetworkManager()
    static let manager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 20
        let manager = NetworkManager(configuration: configuration)
        return manager
    }()

    //MARK:- API Fetcher
    /// Generic method to fetch from server using Alamofire Lib and instead of sending the URL, we are sending it as a URLConvertible. and Result also as generic Codable object.
    /// We have handled both success and failure cases
    func requestData<T>(url: URLRequestConvertible, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Codable {
        NetworkManager.manager.request(url).validate().responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.DecodingError))
                    return
                }
                completion(.success(obj))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        })
    }
}

