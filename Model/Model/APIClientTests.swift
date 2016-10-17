//
//  APIClientTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/14.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest

@testable import ToDo

extension APIClientTests {
    class  MockURLSession : ToDoURLSession {
         typealias Handler = (Data?, URLResponse?, NSError?)
            -> Void
        var completionHandler: Handler?
        var url: URL?
        
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            return URLSession.shared.dataTask(with: url)
        }
    }
}

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin_MakesRequestWithUsernameAndPassword() {
        
        let completion = { (error: Error?) in }
        sut.loginUserWithName(
            "dasdom",
                              password: "1234",
                              completion: completion)
        
        XCTAssertNotNil(mockURLSession.completionHandler)
        guard let url = mockURLSession.url else { XCTFail(); return }
        let urlComponents = NSURLComponents(url: url as URL,
                                            resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        XCTAssertEqual(urlComponents?.path, "/login")
        XCTAssertEqual(urlComponents?.query,
                       "username=dasdom&password=1234")

    }
    
}
