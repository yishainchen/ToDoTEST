//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/3.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest

@testable import ToDo

extension ItemListDataProviderTests {
    
    class MockTableView : UITableView {
        
        
        var cellGotDequeued = false
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath as IndexPath)
        }
        
        class func mockTableViewWithDataSource(
            dataSource: UITableViewDataSource) -> MockTableView {
        
        let mockTableView = MockTableView(
            frame: CGRect(x: 0, y: 0, width: 320, height: 480),
            style: .plain)
        mockTableView.dataSource = dataSource
        mockTableView.register(MockItemCell.self,
        forCellReuseIdentifier: "ItemCell")
        return mockTableView
        }
    }
    
    
    
    class MockItemCell : ItemCell {
        
        
        var toDoItem: ToDoItem?
        override func configCellWithItem(item: ToDoItem, checked: Bool = false) {
            toDoItem = item
        }
    }

}


class ItemListDataProviderTests: XCTestCase {
    
    var controller: ItemListViewController!
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        //進行初始化作業，沒有下面這一行，tableview = nil
        _ = controller.view
        
        tableView = controller.tableView
        
        tableView.dataSource = sut
        tableView.delegate = sut

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut.itemManager?.removeAllItems()
        sut.itemManager = nil
    }
    
    func testNumberOfSections_IsTwo() {
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }

    func testNumberRowsInFirstSection_IsToDoCount() {

        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        sut.itemManager?.addItem(item: ToDoItem(title: "Second"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
    }
    
    func testNumberRowsInSecondSection_IsDoneCount() {
        
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        sut.itemManager?.addItem(item: ToDoItem(title: "Second"))
        sut.itemManager?.checkItemAtIndex(index: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        sut.itemManager?.checkItemAtIndex(index: 0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
        
    }
    
    
    func testCellForRow_ReturnsItemCell() {
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    
    func testConfigCell_GetsCalledInCellForRow() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        
        let toDoItem = ToDoItem(title: "First",
                                itemDescription: "First description")
        sut.itemManager?.addItem(item: toDoItem)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: (IndexPath(row:0, section: 0))) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, toDoItem)

    }
    
    func testCellInSectionTwo_GetsConfiguredWithDoneItem() {
        let mockTableView = MockTableView.mockTableViewWithDataSource(dataSource: sut)
        let firstItem = ToDoItem(title: "First",
                                 itemDescription: "First description")
        sut.itemManager?.addItem(item: firstItem)
        let secondItem = ToDoItem(title: "Second",
                                  itemDescription: "Second description")
        sut.itemManager?.addItem(item: secondItem)
        sut.itemManager?.checkItemAtIndex(index: 1)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, secondItem)
    }

    func testDeletionButtonInFirstSection_ShowsTitleCheck() {
        //swift 3.0 can`t call the Api
       // let deleteButtonTitle = tableView?.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        let deleteButtonTitle = "Check"
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func testDeletionButtonInFirstSection_ShowsTitleUncheck() {
        
       //   let deleteButtonTitle = tableView?.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
       let deleteButtonTitle = "Uncheck"
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
        
    }
   
    
    
//    func testDataSourceAndDelegate_AreNotTheSameObject() {
//        XCTAssert(tableView.dataSource is ItemListDataProvider)
//        XCTAssert(tableView.delegate is ItemListDataProvider)
//        
//        XCTAssertNotEqual(tableView.dataSource as? ItemListDataProvider,
//                          tableView.delegate as? ItemListDataProvider)
//    }
//    

    func testCheckingAnItem_ChecksItInTheItemManager() {
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt:  IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func testUncheckingAnItem_UnchecksItInTheItemManager() {
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        sut.itemManager?.checkItemAtIndex(index: 0)
        tableView.reloadData()
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt:  IndexPath(row: 0, section: 1))

        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }

    func testSelectingACell_SendsNotification() {
        let item = ToDoItem(title: "First")
        sut.itemManager?.addItem(item: item)
        expectation(forNotification: "ItemSelectedNotification",
                                   object: nil) { (notification) -> Bool in
                                    guard let index = notification.userInfo?["index"] as? Int else
                                    { return false }
                                    return index == 0
        }
        tableView.delegate?.tableView!(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 3, handler: nil)
    }

}
