//
//  User+CoreDataClass.swift
//  babelON
//
//  Created by Brandon Roehl on 11/11/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject {
    static func getFrom(predicate: NSPredicate?) -> [User] {
        var fetchResults: [User] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        fetchRequest.predicate = predicate

        do {
            fetchResults = try moc.fetch(fetchRequest)
        } catch {
            print("Error: Can't fetch \(fetchRequest)")
        }
        return fetchResults
    }

    static func findOrCreateBy(username: String) -> User {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "username == %s", username)

        let res = User.getFrom(predicate: predicate)
        if res.count > 0 {
            return res[0]
        }

        let user = User(context: moc)
        user.username = username
        return user
    }
}
