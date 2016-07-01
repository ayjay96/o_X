//
//  UserController.swift
//  o_X
//
//  Created by avarn127 on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    
    static var sharedInstance: UserController =  UserController()
    
    private init () {
        
    }
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        if password.characters.count < 6 {
            onCompletion (nil , "Ya fucked up")
        }
        
        
        for user in users {
            if email == user.email {
                print("Not cool bro, that email is already taken")
            }
            
        }
        var newUser: User = User ()
        newUser.email = email
        newUser.password = password
        self.users.append(newUser)
        
        onCompletion (newUser, nil)
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
   }

    private var users: [User] = []
    
    
    
    
    var currentUser: User?

}