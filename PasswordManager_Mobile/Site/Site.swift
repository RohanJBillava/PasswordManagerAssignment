//
//  Site.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 05/02/22.
//

import Foundation

class Site {
    var url: String
    var name: String
    var sector: String
    var username: String
    var password: String
    var notes: String
    
    init(_url: String, _siteName: String,_sector: String, _username: String, _password: String,_notes: String) {
        url = _url
        name = _siteName
        sector = _sector
        username = _username
        password = _password
        notes = _notes
    }
}
