//
//  PRViewModelTests.swift
//  GithubDemoTests
//
//  Created by ITRS-2310 on 01/11/22.
//

import XCTest
@testable import GithubDemo

class PRViewModelTests: XCTestCase {
    var sut: PRViewModel!

    override func setUpWithError() throws {
        super.setUp()
        sut = PRViewModel(prViewService: MockPRViewService())
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }


    func testPRs() {
        sut.fetchPRs { uiModels, error in
            guard let uiModels = uiModels, let firstPR = uiModels.first else { return }
            XCTAssertEqual(firstPR.componentTitle?.string, "Sema: Fix crash when diagnosing async let bindings in illegal contexts")
            XCTAssert(uiModels.count == 10)
        }
    }

}
