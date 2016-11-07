
//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by B1media on 2016/9/21.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut.removeAllItems()
        sut = nil
    }
    
    func testToDoCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.toDoCount, 0,"Initially toDo count should be 0")
        
    }
    
    func testDoneCount_Initially_ShouldBeZero() {
        XCTAssertEqual(sut.doneCount, 0,
                       "Initially done count should be 0")
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne() {
        sut.addItem(item: ToDoItem(title: "Test title"))
        XCTAssertEqual(sut.toDoCount, 1, "toDoCount should be 1")
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item: item)
        let returnedItem = sut.itemAtIndex(index: 0)
        XCTAssertEqual(item.title, returnedItem.title,
                       "should be the same item")
    }

    func testCheckingItem_ChangesCountOfToDoAndOfDoneItems() {
        sut.addItem(item: ToDoItem(title: "First Item"))
        sut.checkItemAtIndex(index: 0)
        XCTAssertEqual(sut.toDoCount, 0, "toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 1, "doneCount should be 1")
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        sut.addItem(item: firstItem)
        sut.addItem(item: secondItem)
        sut.checkItemAtIndex(index: 0)
        XCTAssertEqual(sut.itemAtIndex(index: 0).title, secondItem.title)
    }
   
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item: item)
        sut.checkItemAtIndex(index: 0)
        let returnedItem = sut.doneItemAtIndex(index: 0)
        XCTAssertEqual(item.title, returnedItem.title,
                       "should be the same item")

    }
    
    func testRemoveAllItems_ShouldResultInCountsBeZero() {
        sut.addItem(item: ToDoItem(title: "First"))
        sut.addItem(item: ToDoItem(title: "Second"))
        sut.checkItemAtIndex(index: 0)
        XCTAssertEqual(sut.toDoCount, 1,
                       "toDoCount should be 1")
        XCTAssertEqual(sut.doneCount, 1,
                       "doneCount should be 1")
        sut.removeAllItems()
        
        XCTAssertEqual(sut.toDoCount, 0, "toDoCount should be 0")
        XCTAssertEqual(sut.doneCount, 0, "doneCount should be 0")
    }
    
    func testAddingTheSameItem_DoesNotIncreaseCount() {
        sut.addItem(item: ToDoItem(title: "First"))
        sut.addItem(item: ToDoItem(title: "First"))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ToDoItemsGetSerialized() {
        var itemManager: ItemManager? = ItemManager()
        let firstItem = ToDoItem(title: "First")
        itemManager!.addItem(item: firstItem)
        let secondItem = ToDoItem(title: "Second")
        itemManager!.addItem(item: secondItem)
        NotificationCenter.default.post(
            name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        itemManager = nil
        XCTAssertNil(itemManager)
        itemManager = ItemManager()
        
        
        XCTAssertEqual(itemManager?.toDoCount, 2)
        XCTAssertEqual(itemManager?.itemAtIndex(index: 0), firstItem)
        XCTAssertEqual(itemManager?.itemAtIndex(index: 1), secondItem)
    }
    
    func test_DoneItemsGetSerialized() {
        var itemManager: ItemManager? = ItemManager()
        let firstItem = ToDoItem(title: "First")
        itemManager!.addItem(item: firstItem)
        let secondItem = ToDoItem(title: "Second")
        itemManager!.addItem(item: secondItem)
        itemManager!.checkItemAtIndex(index: 0)
        NotificationCenter.default.post(
            name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        itemManager = nil
        XCTAssertNil(itemManager)
        itemManager = ItemManager()
        XCTAssertEqual(itemManager?.toDoCount, 1)
        XCTAssertEqual(itemManager?.doneCount, 1)
        XCTAssertEqual(itemManager?.doneItemAtIndex(index: 0), firstItem)
        XCTAssertEqual(itemManager?.itemAtIndex(index: 0), secondItem)
    
    }
    
    

}
