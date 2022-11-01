//
//  URLS.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

///This contains the base URL and the corresponding feature URLs
struct URLS{
    struct Domains {
        static let PROD = "https://api.github.com/repos/apple/swift/"
    }
    static var BASE_URL = Domains.PROD

    struct GitHubFeatures {
        static let getClosedPRs = "pulls?page=1&per_page=10"
    }
}
