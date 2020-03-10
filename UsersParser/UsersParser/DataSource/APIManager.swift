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
    
    static var encoder = JSONEncoder()
    static var decoder = JSONDecoder()
    
    class func make(_ action:Edit, user:User){
        let url = URL(string: "http://localhost:8080/\(action.rawValue)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(user)
        URLSession.shared.dataTask(with: request){
            data,response,error in
            guard let data = data else {return}
            guard let user = try? decoder.decode(User.self, from: data) else {return}
            DispatchQueue.main.async {
                switch action{
                case .Add:
                    CoreDataManager.make(.Add, user: user)
                case .Update:
                    CoreDataManager.make(.Update, user: user)
                case .Delete:
                    CoreDataManager.make(.Delete, user: user)
                default:
                    break
                }
                UserDefaults.standard.set(Date().iso8601, forKey: "lastSync")
            }
        }.resume()
    }
    
    class func syncServer(_ action:Edit, lastSync:User? = nil, _ completion: (() -> ())? = nil){
        let url = URL(string: "http://localhost:8080/\(action.rawValue)")
        var request = URLRequest(url: url!)
        if action == .Sync{
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? encoder.encode(lastSync)
        }
        URLSession.shared.dataTask(with: request){
            data, response, error in
            guard let data = data  else {return}
            guard let users = try? decoder.decode([User].self, from: data) else {return}
            DispatchQueue.main.async {
                switch action{
                case .Sync:
                    syncChanges(syncedUsers: users)
                    completion!()
                case .FullSync:
                    fullSync(syncedUsers: users)
                default:
                    break
                }
            }
        }.resume()
    }
    
    
    private class func syncChanges(syncedUsers:[User]){
        let lastSyncRegister = UserDefaults.standard.string(forKey: "lastSync")
        for syncedUser in syncedUsers{
            if lastSyncRegister != nil{
                if (syncedUser.dateChanged!.iso8601! > lastSyncRegister!.iso8601!) &&
                    (syncedUser.dateCreated!.iso8601! > lastSyncRegister!.iso8601!){
                    CoreDataManager.make(.Add, user: syncedUser)
                }
                else if (syncedUser.dateChanged!.iso8601! > lastSyncRegister!.iso8601!) &&
                    (syncedUser.dateCreated!.iso8601! <= lastSyncRegister!.iso8601!){
                    CoreDataManager.make(.Update, user: syncedUser)
                }
            }
            UserDefaults.standard.set(Date().iso8601, forKey: "lastSync")
        }
    }
    
    private class func fullSync(syncedUsers:[User]){
        print(syncedUsers.count)
        for syncedUser in syncedUsers{
            CoreDataManager.make(.Add, user: syncedUser)
            UserDefaults.standard.set(Date().iso8601, forKey: "lastSync")
        }
        UserDefaults.standard.set(false, forKey: "firstLaunch")
    }
}
