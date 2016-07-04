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
    private init () {}
    
    func register(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        if password.characters.count < 6 {
            onCompletion(nil , "Ya fucked up")
            return
        }
        
        
        for user in users {
            if email == user.email {
                onCompletion(nil , "Not cool bro, that email is already taken")
                return
            }
        }
        
        let newUser = User()
        newUser.email = email
        newUser.password = password
        self.users.append(newUser)
        
        currentUser = newUser
        
        onCompletion(newUser, nil)
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        for user in users {
            if email == user.email && password == user.password {
                onCompletion(user, nil)
                return
            }
            
        }
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        currentUser = nil
        return
            
        
        
    }

    private var users: [User] = []
    
    var currentUser: User?

}