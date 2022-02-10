//
//  Users.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 08/02/22.
//

import Foundation

class Users {
    
    var allUsers: [User] = []
    let _datastore = DataStore()
    
    
    init() {
        self.loadDefaultUsers()
    }
    
    func add(user: User) {

        allUsers.append(user)
        save(data: allUsers)
//        p()
//        print(allUsers.count)
    }
    
//    func p() {
//        for i in allUsers {
//            print("\(i.mobileNumber)\t \(i.mpin)")
//
//        }
//    }
    
    
    func loadDefaultUsers() {
        guard let path = _datastore.path?.path else {
            return
        }
        if FileManager.default.fileExists(atPath: path ) {
            let loadedData = loadData()
            if loadedData.isEmpty {
                print("data failed to load")
            }else {
                for i  in 0..<loadedData.count  {
                    let user = loadedData[i]
                    allUsers.append(User(mobileNumber: user.mobileNumber, mpin: user.mpin))
                }
            }
        }
    }
    
    
    func save(data: [User]){
        _datastore.save(userData: data)
    }
    
    func loadData() -> [User] {
        return _datastore.loadUserData()
    }
    
    
    
    
    func authenticateSignup(mobileNO: String) -> Bool{
        
        var sucess = true
        
        for (_,j) in allUsers.enumerated() {
            if j.mobileNumber == mobileNO  {
                sucess = false
            }
        }
        return sucess
    }
    
    func authenticateSignIn(user: User) -> Bool {
            
        
        var sucess = false
//        p()
//        print(allUsers.count)
        
        for (_,j) in allUsers.enumerated() {
            if j.mobileNumber == user.mobileNumber && j.mpin == user.mpin {
                sucess = true
            }
        }
        return sucess
        }
}
