//
//  ItemManager.swift
//  ToDo
//
//  Created by B1media on 2016/9/21.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation

class ItemManager {
    var toDoCount = 0
    let doneCount = 0
    private var toDoItems = [ToDoItem]()
    
    
    func addItem(item: ToDoItem) {
        toDoCount += 1
        //Swift 3.0 語法 （原本書中展示++toDoCount）
        toDoItems.append(item)
    }
    func itemAtIndex(index: Int) -> ToDoItem {
        return toDoItems[index]
    }

    func checkItemAtIndex(index: Int) {
    }
}
