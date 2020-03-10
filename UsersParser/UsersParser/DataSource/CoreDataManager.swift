
//  CoreDataManager.swift
//  UsersParser
//
//  Created by Harut on 2/28/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.


import Foundation
import CoreData
import UIKit

class CoreDataManager{
    
    @discardableResult class func make(_ action:Edit, user:User?=nil)->[User]?{
        var fetchedUsers = [User]()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return nil}
        
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "UserDb", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDb")
        
        switch action {
        case .Add:
            let userObject = NSManagedObject(entity: entity!, insertInto: context)
            saveUser(object:userObject, user: user!)
        case .Update:
            fetchRequest.predicate = NSPredicate(format: "id = %i", user!.id!)
            guard let fetchedObjects = try? context.fetch(fetchRequest) else{return nil}
            guard let targetObject = fetchedObjects[0] as? NSManagedObject else{return nil}
            updateUser(target: targetObject, user: user!)
        case .Delete:
            fetchRequest.predicate = NSPredicate(format: "id = %i", user!.id!)
            guard let fetchedObjects = try? context.fetch(fetchRequest) else{return nil}
            guard let targetObject = fetchedObjects[0] as? NSManagedObject else{return nil}
            deleteUser(target: targetObject, context: context)
        case .Fetch:
            guard let fetchedObjects = try? context.fetch(fetchRequest) else{return nil}
            fetchedUsers = fetchUsers(users: fetchedObjects as! [NSManagedObject])
            break
        default:
            break
        }
        if action == .Add || action == .Delete || action == .Update{
            do {try context.save()}
            catch {print(error)}
        }
        return fetchedUsers
    }
    
    private class func saveUser(object: NSManagedObject,user: User){
        object.setValuesForKeys([
            "id" : user.id!,
            "name": user.name!,
            "surname": user.surname!,
            "about": user.about!,
            "address":user.address!,
            "email": user.email!,
            "img": user.img!,
            "gender": user.gender!,
            "age": user.age!,
            "phone": user.phone!,
            "dateChanged":user.dateChanged!.iso8601!,
            "dateCreated":user.dateCreated!.iso8601!
        ])
    }
    
    private class func deleteUser(target: NSManagedObject,context:NSManagedObjectContext){
        context.delete(target)
    }
    
    private class func updateUser(target: NSManagedObject,user: User){
        target.setValuesForKeys([
            "id" : user.id!,
            "name": user.name!,
            "surname": user.surname!,
            "about": user.about!,
            "address":user.address!,
            "email": user.email!,
            "img": user.img!,
            "gender": user.gender!,
            "age": user.age!,
            "dateChanged":user.dateChanged!.iso8601!
        ])
    }
    private class func fetchUsers(users: [NSManagedObject]) -> [User]{
        var usersToReturn = [User]()
        
        for user in users{
            let tempUser = User(id: user.value(forKey: "id") as? Int,
                                name: user.value(forKey: "name") as? String,
                                surname: user.value(forKey: "surname") as? String,
                                email: user.value(forKey: "email") as? String,
                                phone: user.value(forKey: "phone") as? String,
                                address: user.value(forKey: "address") as? String,
                                img: user.value(forKey: "img") as? String,
                                gender: user.value(forKey: "gender") as? String,
                                age: user.value(forKey: "age") as? String,
                                about: user.value(forKey: "about") as? String,
                                dateCreated: (user.value(forKey: "dateCreated") as? Date)?.iso8601,
                                dateChanged: (user.value(forKey: "dateChanged") as? Date)?.iso8601)
            usersToReturn.append(tempUser)
        }
        return usersToReturn
    }
    
}
