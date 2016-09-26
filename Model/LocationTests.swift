//
//  LocationTests.swift
//  ToDo
//
//  Created by B1media on 2016/9/21.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1,
                                                    longitude: 2)
        let location = Location(name: "",
                                coordinate: testCoordinate)
        XCTAssertEqual(location.coordinate?.latitude,
                       testCoordinate.latitude,
                       "Initializer should set latitude")
        XCTAssertEqual(location.coordinate?.longitude,
                       testCoordinate.longitude,
                       "Initializer should set longitude")
    }
    
    func testInit_ShouldSetName() {
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name",
                       "Initializer should set the name")
    }

    func testEqualLocations_ShouldBeEqual() {
        let firstLocation = Location(name: "Home")
        let secondLoacation = Location(name: "Home")
        XCTAssertEqual(firstLocation, secondLoacation)
    }
    func performNotEqualTestWithLocationProperties(firstName: String,
                                                   secondName: String,
                                                   firstLongLat: (Double, Double)?,
                                                   secondLongLat: (Double, Double)?,
                                                   line:UInt) {
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(
                latitude: firstLongLat.0,
                longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName,
                                     coordinate: firstCoord)
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(
                latitude: secondLongLat.0,
                longitude: secondLongLat.1)
        } else {
            secondCoord = nil
        }
        let secondLocation = Location(name: secondName,
                                      coordinate: secondCoord)
        XCTAssertNotEqual(firstLocation, secondLocation,line:line)
    }
    
    func testWhenLatitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties (firstName: "Home",
                                                   secondName: "Home",
                                                   firstLongLat: (1.0, 0.0),
                                                   secondLongLat: (0.0, 0.0),
                                                   line:52)
    }
    
   
    


    func testWhenLongitudeDifferes_ShouldBeNotEqual() {
        let firstCoordinate = CLLocationCoordinate2D(latitude: 0.0,
                                                     longitude: 1.0)
        let firstLocation = Location(name: "Home",
                                     coordinate: firstCoordinate)
        let secondCoordinate = CLLocationCoordinate2D(latitude: 0.0,
                                                      longitude: 0.0)
        let secondLocation = Location(name: "Home",
                                      coordinate: secondCoordinate)
        XCTAssertNotEqual(firstLocation, secondLocation)
    }
    

    
}
