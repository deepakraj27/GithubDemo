//
//  FetchPullRequestInit.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

struct FetchPullRequestInit: Codable{
    let page: String?
    let perPage: String?
    let state: String?

    private enum CodingKeys: String, CodingKey {
        case page, state
        case perPage = "per_page"
    }

    init(page: String?, perPage: String?) {
        self.page = page
        self.perPage = perPage
        self.state = "open"
    }
}

extension FetchPullRequestInit{
    var dictionary: [String: AnyObject]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: AnyObject] }
    }
}
