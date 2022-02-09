//
//  User.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 07/02/22.
//

import Foundation

enum Keys: String {
    case mobileNumber = "mobileNumber"
    case mpin = "mpin"
}


class User: NSObject, NSCoding{
    
    
    
    
    let mobileNumber: String
    let mpin: String
    var totalSites: [Site] {
        get {
            return sitesObj.allSites
        }
    }
    var sitesObj = Sites()
    
    init(mobileNumber: String, mpin: String) {
        self.mobileNumber = mobileNumber
        self.mpin = mpin
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(mobileNumber, forKey: Keys.mobileNumber.rawValue)
        coder.encode(mpin, forKey: Keys.mpin.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let no = coder.decodeObject(forKey: Keys.mobileNumber.rawValue) as? String,
              let mpin = coder.decodeObject(forKey: Keys.mpin.rawValue) as?
                String else {
            return nil
        }
        self.init(mobileNumber: no, mpin: mpin)
  
    }
}
