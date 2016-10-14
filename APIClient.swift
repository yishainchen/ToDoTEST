//
//  APIClient.swift
//  ToDo
//
//  Created by B1media on 2016/10/14.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation



protocol ToDoURLSession {
    func dataTaskWithURL(url: NSURL,
                         completionHandler: (NSData?, URLResponse?, NSError?) ->
        Void) -> URLSessionDataTask
}


class APIClient {
    lazy var session: ToDoURLSession = URLSession.shared
    
    func loginUserWithName(username: String,
                           password: String,
                           completion: (Error?) -> Void) {
        
        
        guard let url = NSURL(string: "https://awesometodos.com/login?username=\(username)&password=\(password)") else
                { fatalError() }
        
    }
}

extension URLSession : ToDoURLSession {

}
