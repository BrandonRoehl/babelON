//
//  conversation.swift
//  babelON
//
//  Created by Potato on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import UIKit

class Conversation: NSObject {

    var id:Int
    var participants:[User]
    var msgHistory:[Message]
    override var description: String {
        var names:String = ""
        for each in participants {
            names.append(each.firstName)
        }
        return names
    }
    
    init(id:Int, participants:[User], msgHistory:[Message]){
        self.id = id
        self.participants = participants
        self.msgHistory = msgHistory
        
    }
    
    
}
