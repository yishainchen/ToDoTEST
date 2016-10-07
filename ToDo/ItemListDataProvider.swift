//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by B1media on 2016/10/3.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import UIKit

enum Section: Int {
    case ToDo
    case Done
}

class ItemListDataProvider: NSObject,UITableViewDataSource {
    
    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        let numberOfRows: Int
        switch itemSection {
        case .ToDo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            return ItemCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    

    
}
