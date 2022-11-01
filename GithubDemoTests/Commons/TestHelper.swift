//
//  XCTestCase+JSON.swift
//  GithubDemoTests
//
//  Created by ITRS-2310 on 01/11/22.
//

import Foundation

enum TestError: Error {
    case fileNotFound
}

class TestHelper {
    static let shared = TestHelper()

    func getData(fromJSON fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw TestError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw error
        }
    }
}
