//
//  PRViewModel.swift
//  GithubDemo
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

class PRViewModel {
    // number of items to be fetched each time
    private let itemsPerBatch = 10
    // Where to start fetching items
    private var page = 1
    // a flag for when all items have already been loaded
    private var reachedEndOfItems = false

    let prViewService: PRViewServiceDelegate

    ///this is added because we can use it for unit testing...
    init(prViewService: PRViewServiceDelegate = PRViewService()) {
        self.prViewService = prViewService
    }

    var pullRequestList: [PullRequest] = [PullRequest]()
    var isLoading: Bool = false

    func fetchPRs(completion: @escaping(_ uiModels: [PRUIViewModel]?, _ error: NetworkError?) -> Void) {
        guard !self.reachedEndOfItems else {
            return
        }

        if !isLoading {
            self.isLoading = true

            var thisBatchItems: [PullRequest]? = nil
            let queryParams = FetchPullRequestInit(page: "\(page)", perPage: "\(itemsPerBatch)")

            prViewService.getClosedPRs(queryParams: queryParams) {[weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let pullRequests):
                    self.isLoading = false

                    thisBatchItems = pullRequests
                    if let newItems = thisBatchItems {
                        self.pullRequestList.append(contentsOf: newItems)
                        // check if this was the last of the data
                        if newItems.count < self.itemsPerBatch {
                            self.reachedEndOfItems = true
                            print("reached end of data. Batch count: \(newItems.count)")
                        }
                        self.page += 1

                        if self.pullRequestList.count > 0 {
                            var resultsVMs = [PRUIViewModel]()
                            self.pullRequestList.forEach { eachPR in
                                resultsVMs.append(PRUIViewModel(eachPR))
                            }
                            completion(resultsVMs, nil)
                        } else {
                            completion(nil, .NoData)
                        }
                    }
                case .failure(let error):
                    self.isLoading = false
                    //corner case to handle the failure if the data already present send it
                    if self.pullRequestList.count > 0 {
                        var resultsVMs = [PRUIViewModel]()
                        self.pullRequestList.forEach { eachPR in
                            resultsVMs.append(PRUIViewModel(eachPR))
                        }
                        completion(resultsVMs, nil)
                    } else {
                        completion(nil, .APIError(error.localizedDescription))
                    }
                }
            }
        }
    }


    func didLoadNextPage(completion: @escaping(_ uiModels: [PRUIViewModel]?, _ error: NetworkError?) -> Void) {
        self.fetchPRs(completion: completion)
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
