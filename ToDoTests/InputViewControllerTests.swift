//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by B1media on 2016/10/13.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest
import CoreLocation

@testable import ToDo


extension InputViewControllerTests {
    
    
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        override func geocodeAddressString(_ addressString: String,
                                           completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    class MockPlacemark : CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate
                else{
                return CLLocation()
            }
            return CLLocation(latitude: coordinate.latitude,longitude: coordinate.longitude)
        }
    }

}

class InputViewControllerTests: XCTestCase {
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        sut.itemManager = ItemManager()
        sut.save()
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851,
                                                    -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        let item = sut.itemManager?.itemAtIndex(index: 0)
        let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 1456070400,  location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut,
                                                        forControlEvent: .touchUpInside) else {
                                                            XCTFail(); return
        }
        
        XCTAssertTrue(actions.contains("save:"))
    }

    
    func test_GeocoderWorksAsExpected() {
        let expectationNew = expectation(description: "Wait for geocode")

        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return }
            XCTAssertEqualWithAccuracy(latitude, 37.3316941,accuracy: 0.000001)
            XCTAssertEqualWithAccuracy(longitude, -122.030127,accuracy: 0.000001)
            expectationNew.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }

}
