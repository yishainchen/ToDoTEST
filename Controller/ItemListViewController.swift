//
//  ItemListViewController.swift
//  ToDo
//
//  Created by B1media on 2016/10/3.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet var dataProvider: ItemListDataProvider!
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate>!
    
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
