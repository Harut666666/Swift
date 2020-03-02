//
//  DataSource.swift
//  UsersParser
//
//  Created by Harut on 2/16/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import Foundation
import Network
import CoreData
import UIKit

class APIManager{
    
    class func getUsers(completion: @escaping([User])->()){
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied{
                print("We are connected")
                let url = URL(string: "http://localhost:8080/showusers")!
                URLSession.shared.dataTask(with: url){
                    data, respons, error in
                    guard let data = data else {print(error?.localizedDescription ?? "Unknown error")
                        return
                    }
                    let decoder = JSONDecoder()
                    if let users = try? decoder.decode([User].self, from: data){
                        completion(users)
                    }else{
                        print("Unable to parse JSON")
                    }
                }.resume()
            }else{
                print("No internet connection")
                completion(CoreDataManager.make(.Fetch)!)
               }
            }
        }
    

    class func editUser(mode:String, user:User){
           let url = URL(string: "http://localhost:8080/\(mode)")!
           let encoder = JSONEncoder()
           var req = URLRequest(url: url)
           req.httpMethod = "POST"
           req.setValue("application/json", forHTTPHeaderField: "Content-Type")
           req.httpBody = try? encoder.encode(user)
        
            URLSession.shared.dataTask(with: req){
                   data,response,error in
                     guard let data = data else {print(error?.localizedDescription ?? "Unknown error")
                         return}
                     let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                     if let user = try? decoder.decode(User.self, from: data) {
                        print(user.id!)
                        if mode == "adduser"{
                        _ = CoreDataManager.make(.Add, user: user)
                        }
                     }
                UserDefaults.standard.set(Date().iso8601, forKey: "lastSync")
            }.resume()
       }
    
    class func syncUser(user:User){
        let url = URL(string: "http://localhost:8080/sync")!
        let encoder = JSONEncoder()
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? encoder.encode(user)
         URLSession.shared.dataTask(with: req){
                data,response,error in
                  guard let data = data else {print(error?.localizedDescription ?? "Unknown error")
                      return}
                  let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 decoder.dateDecodingStrategy = .iso8601
                  if let users = try? decoder.decode([User].self, from: data) {
                    print("User count API : \(users.count)")
                    for user in users{
                        if (user.dateChanged!.iso8601! > user.dateCreated!.iso8601!){
                           _ = CoreDataManager.make(.Update, user: user)
                        }
                        else{
                            _ = CoreDataManager.make(.Add, user: user)
                        }
                       
                    }
                  }
             UserDefaults.standard.set(Date().iso8601, forKey: "lastSync")
              }.resume()
    }
}
