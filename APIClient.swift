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
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(_ username: String,
                           password: String,
                           completion: (@escaping (Error?) -> Void)) {
        
        let allowedCharacters = CharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
            else {
                fatalError()
        }
        guard let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
            else {
                fatalError()
        }
        guard let url = URL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else
        { fatalError() }
      
        let task = session.dataTask(with: url) { (data, response,
            error) -> Void in
            let responseDict = try! JSONSerialization.jsonObject(with: data!,options: [])
            let token = responseDict["token"] as! String
            self.keychainManager?.setPassword(token,account: "token")
            
        }
        task.resume()
    }
}
protocol ToDoURLSession {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession : ToDoURLSession {
    
}
