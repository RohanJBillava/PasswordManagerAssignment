//
//  Sites.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 05/02/22.
//

import Foundation

class Sites {
    var allSites:[Site] = []
    var count: Int {
        get {
            return allSites.count
        }
    }
    
    init() {
        self.loadDefaultSites()
    }
    
    func loadDefaultSites() {
        allSites.append(Site(_url: "www.facebook.com", _siteName: "Facebook", _sector: "social media", _username: "rohan", _password: "kjdfghhjkdgf", _notes: "nothing"))
        allSites.append(Site(_url: "www.instagram.com", _siteName: "Instagram", _sector: "social media", _username: "billava", _password: "kjjkh", _notes: "jhkh"))
        allSites.append(Site(_url: "www.twitter.com", _siteName: "Twitter", _sector: "social media", _username: "intruder", _password: "idk", _notes: "nothing"))
    }
    
    func add(site: Site) {
        allSites.append(site)
    }
    
    func site(at index: Int) -> Site? {
        if (index < 0 || index > count) {
            return nil
        }
        return allSites[index]
    }
}
