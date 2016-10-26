//
//  ItemListViewControllerTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/3.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest

@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
    
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
            _ = sut.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TableViewIsNotNilAfterViewDidLoad() {
        
            XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        
            XCTAssertNotNil(sut.tableView.dataSource)
            XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    
    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider,
                       sut.tableView.delegate as? ItemListDataProvider)
    }
    
    func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as?
            UIViewController, sut)
        
    }
    
//    func testAddItem_PresentsAddItemViewController() {
//        XCTAssertNil(sut.presentedViewController)
//        guard let addButton = sut.navigationItem.rightBarButtonItem else
//        { XCTFail(); return }
//        sut.performSelector(inBackground: addButton.action!, with: addButton)
//        XCTAssertNotNil(sut.presentedViewController)
//        XCTAssertTrue(sut.presentedViewController is InputViewController)
//        
//    }

}
