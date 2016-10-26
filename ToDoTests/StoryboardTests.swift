//
//  StoryboardTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/26.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest

@testable import ToDo

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialViewController_IsItemListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is ItemListViewController)
    }
    
}
