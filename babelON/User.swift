//
//  user.swift
//  babelON
//
//  Created by Potato on 11/10/18.
//  Copyright © 2018 Quinn Huettner. All rights reserved.
//

import UIKit

class User: NSObject {

    var id:Int
    var username:String
    var firstName:String
    var lastName:String
    var email:String
    var language:String
    
    init(id:Int, username:String, firstName:String, lastName:String, email:String, language:String){
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.language = language
        
    }
    
    
}
