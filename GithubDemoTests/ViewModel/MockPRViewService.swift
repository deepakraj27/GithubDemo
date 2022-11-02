//
//  MockPRViewService.swift
//  GithubDemoTests
//
//  Created by ITRS-2310 on 01/11/22.
//

import XCTest
@testable import GithubDemo

class MockPRViewService: PRViewServiceDelegate {
    func getClosedPRs(queryParams: FetchPullRequestInit, completion: @escaping (Result<[PullRequest], NetworkError>) -> Void) {
        do {
            let jsonData = try TestHelper.shared.getData(fromJSON: "pullrequests")
            let obj = try  JSONDecoder().decode([PullRequest].self, from: jsonData)
            completion(.success(obj))
        } catch TestError.fileNotFound {
            completion(.failure(.APIError("cannot find the json file")))
        } catch {
            print(error)
            completion(.failure(.DecodingError))
        }
    }
}
