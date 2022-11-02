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
    static var BEARER_AUTH = "Bearer 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"

    struct GitHubFeatures {
        static let getClosedPRs = "pulls"
    }
}
