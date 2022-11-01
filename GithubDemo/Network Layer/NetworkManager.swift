//
//  Network Manager.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import Alamofire

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
    func requestData<T>(url: URLRequestConvertible, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        NetworkManager.manager.request(url).validate().responseData(completionHandler: { response in
            switch response.result {

            case .success(let data):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: data)))
                        } catch let error {
                            completion(.failure(error))
                        }
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

