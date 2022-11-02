//
//  APIRouter.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation
import Alamofire

//MARK:- APIRouter
///This class has url request convertible and it has all urls for a feature with metho and path and passed as url request
enum APIRouter: URLRequestConvertible {
    case getClosedPRs(queryParams: Parameters)

    var method: HTTPMethod {
        switch self {
        case .getClosedPRs:
            return .get
        }
    }

    var path : String{
        switch self {
        case .getClosedPRs:
            return URLS.GitHubFeatures.getClosedPRs
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try URLS.BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60

        switch self {
        case .getClosedPRs(let queryParams):
            urlRequest.addValue(URLS.BEARER_AUTH, forHTTPHeaderField: "Authorization")
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
        default:
            break
        }
        return urlRequest
    }
}
