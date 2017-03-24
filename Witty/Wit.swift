//
//  Wit.swift
//  Witty
//
//  Created by Zeean Veljee on 01/06/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import Foundation
import Firebase

class Wit {
    
    fileprivate var _witRef: FIRDatabaseReference!
    
    fileprivate var _witKey: String!
    fileprivate var _witText: String!
    fileprivate var _witVotes: Int!
    fileprivate var _username: String!
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._witKey = key
        
        
        
        if let votes = dictionary["votes"] as? Int {
            print(votes)
            self._witVotes = votes
        }
        
        if let wit = dictionary["witText"] as? String {
            print(wit)
            self._witText = wit
        }
        
        if let user = dictionary["author"] as? String {
            print(user)
            self._username = user
        }
        else {
            self._username = ""
        }
        
        self._witRef = DataService.dataService.WIT_REF.child(self._witKey)
    }

    
    var witKey: String {
        return _witKey
    }
    
    var witText: String {
        return _witText
    }
    
    var witVotes: Int {
        return _witVotes
    }
    
    var username: String {
        return _username
    }
    
    
    func addSubtractVote(_ addVote: Bool) {
        if addVote {
            _witVotes = _witVotes + 1
        }
        else {
            _witVotes = _witVotes - 1
        }
        
        _witRef.child("votes").setValue(_witVotes)
    }
}
