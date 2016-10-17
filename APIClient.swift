//
//  APIClient.swift
//  ToDo
//
//  Created by B1media on 2016/10/14.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import Foundation




class APIClient {
    lazy var session: ToDoURLSession = URLSession.shared
    
    func loginUserWithName(_ username: String,
                           password: String,
                           completion: (@escaping (Error?) -> Void)) {
        
        
        guard let url = NSURL(string: "https://awesometodos.com/login?username=\(username)&password=\(password)") else
        { fatalError() }
      
        
    }
}


protocol ToDoURLSession {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}


extension URLSession : ToDoURLSession {

}
