//
//  DataStore.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 08/02/22.
//

import Foundation


class DataStore {
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("users data")
    
    func save(userData: [User])  {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
            guard let path = path else {return}
            print(path)
            try data.write(to: path)
        }catch{
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func loadUserData() -> [User] {
        guard let path = path else {return []}
        do {
            let data = try Data(contentsOf: path)
            if let users = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [User] {
                return users
            }else {
                return []
            }
        }catch {
            print("ERROR\(error.localizedDescription)")
            return []
        }
    }
    
    
}
