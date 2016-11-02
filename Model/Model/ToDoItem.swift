//
//  ToDoItem.swift
//  ToDo
//
//  Created by B1media on 2016/9/20.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation

struct ToDoItem : Equatable{
     
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    fileprivate let titleKey = "titleKey"
    fileprivate let itemDescriptionKey = "itemDescriptionKey"
    fileprivate let timestampKey = "timestampKey"
    fileprivate let locationKey = "locationKey"
    
    var plistDict: NSDictionary {
        var dict = [String:AnyObject]()
        dict[titleKey] = title as AnyObject?
        if let itemDescription = itemDescription {
            dict[itemDescriptionKey] = itemDescription as AnyObject?
        }
        if let timestamp = timestamp {
            dict[timestampKey] = timestamp as AnyObject?
        }
        if let location = location {
            let locationDict = location.plistDict
            dict[locationKey] = locationDict
        }
        return dict as NSDictionary
    }
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
}


func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    
    if lhs.location != rhs.location {
        return false
    }
    if lhs.timestamp != rhs.timestamp {
        return false
    }
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
    if lhs.title != rhs.title {
        return false
    }
    return true
}
