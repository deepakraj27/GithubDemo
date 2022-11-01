//
//  PRViewServiceHandler.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

protocol PRViewServiceDelegate {
    func getClosedPRs(completion: @escaping(Result<[PullRequest], NetworkError>) -> Void)
}

class PRViewService: PRViewServiceDelegate {
    func getClosedPRs(completion: @escaping (Result<[PullRequest], NetworkError>) -> Void) {
        guard let queryParams = FetchPullRequestInit(page: "1").dictionary else {return}
        NetworkManager.sharedInstance.requestData(url: APIRouter.getClosedPRs(queryParams: queryParams), completion: completion)
    }
}
