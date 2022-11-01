//
//  PRUser.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

// MARK: - User
struct PRUser: Codable {
    let name: String?
    let avatarURL: String?

    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
    }
}
