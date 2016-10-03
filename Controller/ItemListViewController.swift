//
//  ItemListViewController.swift
//  ToDo
//
//  Created by B1media on 2016/10/3.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
