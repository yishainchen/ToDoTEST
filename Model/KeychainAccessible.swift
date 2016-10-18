//
//  KeychainAccessible.swift
//  ToDo
//
//  Created by B1media on 2016/10/18.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
    func setPassword(password: String,
                     account: String)
    func deletePasswortForAccount(account: String)
    func passwordForAccount(account: String) -> String?
}
