//
//  PullRequest.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

struct PullRequest: Codable {
    let title: String?
    let user: PRUser?
    let createdAt, closedAt: String?

    private enum CodingKeys: String, CodingKey {
        case title, user
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
}
