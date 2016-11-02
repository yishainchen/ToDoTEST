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
     let itemManager = ItemManager()
//    @IBOutlet var dataProvider: ItemListDataProvider!
    @IBOutlet var dataProvider: UITableViewDataSource & UITableViewDelegate & ItemManagerSettable?
    
    override func viewDidLoad() {
        
        dataProvider?.itemManager = itemManager

        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        NotificationCenter.default.addObserver(self, selector: #selector(ItemListViewController.showDetails(_:)), name: NSNotification.Name(rawValue: "ItemSelectedNotification"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addItem(_ sender: AnyObject) {
        
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController")
        as? InputViewController {
            nextViewController.itemManager = self.itemManager
            present(nextViewController, animated: true,
                                  completion: nil)
        }
    }
    func showDetails(_ sender: Notification) {
        guard let index = (sender as NSNotification).userInfo?["index"] as? Int else
        { fatalError() }
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            nextViewController.itemInfo = (itemManager, index)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
            
}

// @objc原因是我們的dataprovider是在storyboard init的
@objc protocol ItemManagerSettable {
    var itemManager: ItemManager? { get set }
}
