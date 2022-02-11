//
//  Sites.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 05/02/22.
//

import Foundation

public enum Categories: String {
    case SocialMedia = "Social Media"
    case Banking = "Banking"
    case Gaming = "Gaming"
    case All = "All"
}

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
        allSites.append(Site(_url: "www.facebook.com", _siteName: "Facebook", _sector: Categories.SocialMedia.rawValue, _username: "rohan", _password: "kjdfghhjkdgf", _notes: "nothing"))
        allSites.append(Site(_url: "www.instagram.com", _siteName: "Instagram", _sector: Categories.SocialMedia.rawValue, _username: "billava", _password: "kjjkh", _notes: "jhkh"))
        allSites.append(Site(_url: "www.twitter.com", _siteName: "Twitter", _sector: Categories.SocialMedia.rawValue, _username: "intruder", _password: "idk", _notes: "nothing"))
        allSites.append(Site(_url: "www.icici.banking.com", _siteName: "ICICI BAnk", _sector: Categories.Banking.rawValue, _username: "rahul", _password: "454*-454hghgh", _notes: "nil"))
        allSites.append(Site(_url: "www.bob.banking.com", _siteName: "Bank Of Baroda", _sector: Categories.Banking.rawValue, _username: "rohan", _password: "jhgjg-+*/65", _notes: "nil"))
        allSites.append(Site(_url: "www.battlegroundsmobile.com", _siteName: "BGMI", _sector: Categories.Gaming.rawValue, _username: "rohan", _password: "gjhfhv", _notes: ""))
        allSites.append(Site(_url: "www.supercell.coc.com", _siteName: "Clash Of Clans", _sector: Categories.Gaming.rawValue, _username: "rohan", _password: "gjksghdjk5454", _notes: ""))
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
