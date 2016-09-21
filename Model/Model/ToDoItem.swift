//
//  ToDoItem.swift
//  ToDo
//
//  Created by B1media on 2016/9/20.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation

struct ToDoItem {
     
    let title: String
    let itemDescription: String?
    
    
    init(title: String, itemDescription: String? = nil) {
        self.title = title
        self.itemDescription = itemDescription
    }
}
