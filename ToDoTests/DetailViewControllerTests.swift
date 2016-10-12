//
//  DetailViewControllerTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/12.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest
import CoreLocation

 @testable import ToDo

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as! DetailViewController
        _ = sut.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_HasTitleLabel() {

        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277,
                                                longitude: 6.7735)
        let itemManager = ItemManager()
        itemManager.addItem(item: ToDoItem(title: "The title",
                                     itemDescription: "The description",
                                     timestamp: 1456150025,
                                     location: Location(name: "Home", coordinate: coordinate)))
        sut.itemInfo = (itemManager, 0)
    }
}
