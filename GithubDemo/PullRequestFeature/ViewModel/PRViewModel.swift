//
//  PRViewModel.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

class PRViewModel {

    let prViewService: PRViewServiceDelegate
    ///this is added because we can use it for unit testing...
    init(prViewService: PRViewServiceDelegate = PRViewService()) {
        self.prViewService = prViewService
    }

    var pullRequestList: [PullRequest] = [PullRequest]()

    func fetchPRs(completion: @escaping(_ uiModels: [PRUIViewModel]?, _ error: NetworkError?) -> Void) {
        prViewService.getClosedPRs { result in
            switch result {
            case .success(let pullRequests):
                print("number of prs: ", pullRequests.count)
                self.pullRequestList = pullRequests

                if self.pullRequestList.count > 0 {
                    var resultsVMs = [PRUIViewModel]()
                    pullRequests.forEach { eachPR in
                        resultsVMs.append(PRUIViewModel(eachPR))
                    }
                    completion(resultsVMs, nil)
                } else {
                    completion(nil, .NoData)
                }
            case .failure(let error):
                completion(nil, .APIError(error.localizedDescription))
            }
        }
    }

    func errorMapper(error: NetworkError?) -> String {
        if let error = error{
            switch error {
            case .NoData:
                return "No data found, Pls try again"
            case .DecodingError:
                return "Something went wrong at the time of Decoding the data."
            case .APIError(let string):
                return string
            }
        }
        return "Something went wrong!, Pls try again"
    }
}
