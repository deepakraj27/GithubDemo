//
//  PRUserTests.swift
//  GithubDemoTests
//
//  Created by ITRS-2310 on 01/11/22.
//

import XCTest
@testable import GithubDemo

class PRUserTests: XCTestCase {
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
        let firstPRUser = sut.first!.user!
        XCTAssertEqual(firstPRUser.name, "tshortli")
        XCTAssertEqual(firstPRUser.avatarURL, "https://avatars.githubusercontent.com/u/16380168?v=4")
    }

}
