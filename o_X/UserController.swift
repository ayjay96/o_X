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
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
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
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        //saves it to the phone as a file right away
        
        onCompletion(newUser, nil)
    }
    
    func login(email email: String, password: String, onCompletion: (User?, String?) -> Void) {
        defaults.setObject(email, forKey: "currentUserLoginEmail")
        defaults.setObject(password, forKey: "currentUserLoginPassword")
        defaults.synchronize()
        for user in users {
            if email == user.email && password == user.password {
                onCompletion(user, nil)
                return
            }
            
        }
    }
    
    func logout(onCompletion onCompletion: (String?) -> Void) {
        defaults.removeObjectForKey("currentUserEmail")
        defaults.removeObjectForKey("currentUserEmail")
        defaults.synchronize()
        currentUser = nil
        return
            
        
        
    }

    private var users: [User] = []
    
    var currentUser: User?

}