//
//  User.swift
//  WatchHorseTv
//
//  Created by tahir hameed on 30/06/2019.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class User: NSObject {

    var firstName : String = ""
    var lastName  : String = ""
    var userName  : String = ""
    var email     : String = ""

    override init() {
        super.init()
    }
    
    init(Data dictionary:[String: Any]){
        super.init()
        
        if let aisoCode = dictionary["firstName"] as? String {
            firstName = aisoCode
        }
        if let aname = dictionary["lastName"] as? String {
            lastName = aname
        }
        if let aphoneCountryCode = dictionary["userName"] as? String {
            userName = aphoneCountryCode
        }
        if let aphoneCountryCode = dictionary["email"] as? String {
            email = aphoneCountryCode
        }
    }
    
    class func Populate(dictionary:[String: Any]) -> User {
        let obj = User(Data: dictionary)
        return obj
    }
    
    class func PopulateArray(array:[[String: Any]]) -> [User] {
        var result :[User] = []
        for item in array {
            let obj = User(Data: item)
            result.append(obj)
        }
        return result
    }
}
