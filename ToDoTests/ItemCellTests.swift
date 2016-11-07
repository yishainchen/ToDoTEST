//
//  ItemCellTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/12.
//  Copyright © 2016年 yishainChen. All rights reserved.
//
// 書上有一個小bug
//http://stackoverflow.com/questions/38719436/caught-nsinternalinconsistencyexception-request-for-rect-at-invalid-indexpath/39065149#39065149
//感謝蜂哥

import XCTest

@testable import ToDo

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
                return UITableViewCell()
        } }
}


class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    var dataSource: UITableViewDataSource!
    
    override func setUp() {
        super.setUp()
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = controller.view
        tableView = controller.tableView
        // 要生成instance才能做source
        dataSource = FakeDataSource()
        tableView.dataSource = dataSource

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSUT_HasNameLabel() {
        
        let cell = tableView?.dequeueReusableCell(
            withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        XCTAssertNotNil(cell.titleLabel)
    }
    func testSUT_HasLocationLabel() {
        
        let cell = tableView?.dequeueReusableCell(
            withIdentifier:"ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testSUT_HasDateLabel() {
        
        let cell = tableView?.dequeueReusableCell(
            withIdentifier:"ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testConfigWithItem_SetsLabelTexts() {
        let cell = tableView?.dequeueReusableCell(
            withIdentifier:"ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        cell.configCellWithItem(item: ToDoItem(title: "First", itemDescription:
            nil, timestamp: 1456150025, location: Location(name: "Home")))
        XCTAssertEqual(cell.titleLabel.text, "First")
        XCTAssertEqual(cell.locationLabel.text, "Home")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func testTitle_ForCheckedTasks_IsStrokeThrough() {
        let cell = tableView?.dequeueReusableCell(
            withIdentifier:"ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        let toDoItem = ToDoItem(title: "First",
                                itemDescription: nil,
                                timestamp: 1456150025,
                                location: Location(name: "Home"))
        cell.configCellWithItem(item: toDoItem, checked: true)
        let attributedString = NSAttributedString(string: "First",
                                                  attributes: [NSStrikethroughStyleAttributeName:
                                                    NSUnderlineStyle.styleSingle.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
    
}
