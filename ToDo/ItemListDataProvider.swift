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

class ItemListDataProvider: NSObject, UITableViewDataSource,  UITableViewDelegate, ItemManagerSettable  {
    
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
    
    func tableView(tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAtIndexPath indexPath:
        NSIndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        let buttonTitle: String
        switch section {
        case .ToDo:
            buttonTitle = "Check"
        case .Done:
            buttonTitle = "Uncheck"
        }
        return buttonTitle
    }

    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ItemCell",
                for: indexPath) as! ItemCell
            guard let itemManager = itemManager else { fatalError() }
            guard let section = Section(rawValue: indexPath.section) else
            {
                fatalError()
            }
            let item: ToDoItem
            switch section {
            case .ToDo:
                item = itemManager.itemAtIndex(index: indexPath.row)
            case .Done:
                item = itemManager.doneItemAtIndex(index: indexPath.row)
            }
            cell.configCellWithItem(item: item)
            return cell
            
            
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: indexPath.section) else
        {
            fatalError()
        }
        switch section {
        case .ToDo:
            itemManager.checkItemAtIndex(index: indexPath.row)
        case .Done:
            itemManager.uncheckItemAtIndex(index: indexPath.row)
        }
        tableView.reloadData()
    }
    // chapter6
    func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        guard let itemSection = Section(rawValue: (indexPath as NSIndexPath).section) else
        { fatalError() }
        switch itemSection {
        case .ToDo:
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ItemSelectedNotification"),
                object: self,
                userInfo: ["index": (indexPath as NSIndexPath).row])
        default:
            break
        }
    }
}
