//
//  DataService.swift
//  Witty
//
//  Created by Zeean Veljee on 01/06/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let dataService = DataService()

    
    fileprivate var _BASE_REF = FIRDatabase.database().reference()
    fileprivate var _USER_REF = FIRDatabase.database().reference(fromURL: "\(BASE_URL)/users")
    fileprivate var _WIT_REF = FIRDatabase.database().reference(fromURL: "\(BASE_URL)/wits")
    let userID = UserDefaults.standard.value(forKey: "uid") as! String

    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
        let userID = UserDefaults.standard.value(forKey: "uid") as! String
        print(userID)
        
        let currentUser = FIRDatabase.database().reference().child("users").child(userID)
        print(currentUser)
        return currentUser
        
    }
    
    var WIT_REF: FIRDatabaseReference {
        return _WIT_REF
    }
    
    func createNewAccount(_ uid: String, user: Dictionary<String, String>) {
        USER_REF.child(uid).setValue(user)
    }
    
    func createNewWit(_ joke: Dictionary<String, AnyObject>) {
        let NewWit = WIT_REF.childByAutoId()
        NewWit.setValue(joke)
    }
}
