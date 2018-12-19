//
//  Message+CoreDataClass.swift
//  babelON
//
//  Created by Brandon Roehl on 11/11/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Message)
public class Message: NSManagedObject {
    static func getFrom(predicate: NSPredicate?) -> [Message] {
        var fetchResults: [Message] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        fetchRequest.predicate = predicate

        do {
            fetchResults = try moc.fetch(fetchRequest)
        } catch {
            print("Error: Can't fetch \(fetchRequest)")
        }
        return fetchResults
    }

    static func findOrCreateBy(id: Int) -> Message {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "id == %ld", id)

        let res = Message.getFrom(predicate: predicate)
        if res.count > 0 {
            return res[0]
        }

        let msg = Message(context: moc)
        msg.id = id
        return msg
    }
}
