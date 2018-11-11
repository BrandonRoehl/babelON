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

@objc(Conversation)
public class Conversation: NSManagedObject {
    override public var description: String {
        // Returns a comma seperated list of usernames
        return ((users?.allObjects as? [User]) ?? []).map({$0.username ?? ""}).joined(separator:",")
    }
}
