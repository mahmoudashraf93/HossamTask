//
//  UserUtilityClass.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/10/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit
import CoreData

class UserUtilityClass: NSObject {

    static let sharedInstance: UserUtilityClass = {
        let instance = UserUtilityClass()
        
        // setup code
        
        return instance
    }()
    
    
    func getUser() -> User {
        let managedContext =
            Constants.APPDELEGATE.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        var users: Array<User> = []
        
        do {
            users = try managedContext.fetch(fetchRequest)
            
            
            return users[0]
        } catch {
            
        }
        return users[0]
        
    }
    func isUserLoggedIn ()-> Bool{
    
        if self.getUser().name != nil{
        return true
        }
        
        else {
        return false
        }
    
    
    
    }
    


}
