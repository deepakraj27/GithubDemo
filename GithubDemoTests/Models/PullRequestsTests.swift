//
//  PullRequestTests.swift
//  GithubDemoTests
//
//  Created by ITRS-2310 on 01/11/22.
//

import XCTest
@testable import GithubDemo

class PullRequestsTests: XCTestCase {
    var sut: [PullRequest]!

    override func setUpWithError() throws {
        let data = try TestHelper.shared.getData(fromJSON: "pullrequest")
        sut = try JSONDecoder().decode([PullRequest].self, from: data)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testFirstPRJSONMapping() {
        let firstPR = sut.first!
        XCTAssertEqual(firstPR.title, "Sema: Fix crash when diagnosing async let bindings in illegal contexts")
        XCTAssertEqual(firstPR.createdAt, "2022-11-01T06:53:07Z")
    }
}
