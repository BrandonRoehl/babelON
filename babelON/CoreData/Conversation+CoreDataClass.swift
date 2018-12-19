//
//  Conversation+CoreDataClass.swift
//  babelON
//
//  Created by Brandon Roehl on 11/11/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Conversation)
public class Conversation: NSManagedObject {
    override public var description: String {
        // Returns a comma seperated list of usernames
        return ((users?.allObjects as? [User]) ?? []).map({$0.username ?? ""}).joined(separator:",")
    }

    static func getFrom(predicate: NSPredicate?) -> [Conversation] {
        var fetchResults: [Conversation] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = predicate

        do {
            fetchResults = try moc.fetch(fetchRequest)
        } catch {
            print("Error: Can't fetch \(fetchRequest)")
        }
        return fetchResults
    }

    static func findOrCreateBy(id: Int32) -> Conversation {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let moc: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let predicate = NSPredicate(format: "id == %ld", id)

        let res = Conversation.getFrom(predicate: predicate)
        if res.count > 0 {
            return res[0]
        }

        let conv = Conversation(context: moc)
        conv.id = id
        return conv
    }
}
