//
//  Message+CoreDataProperties.swift
//  babelON
//
//  Created by Brandon Roehl on 11/11/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var transContent: String?
    @NSManaged public var sentUser: User?
    @NSManaged public var conversation: Conversation?

}
