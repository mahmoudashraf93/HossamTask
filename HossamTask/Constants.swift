//
//  Constants.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/9/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Constants {
    
    
   static let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
   static let MANAGEDCONTEXT =
        APPDELEGATE.persistentContainer.viewContext
    
    // 2
   static let ENTITY =
        NSEntityDescription.entity(forEntityName: "Item",
                                   in: MANAGEDCONTEXT)!
    
    static let ENTITYUSER =
        NSEntityDescription.entity(forEntityName: "User",
                                   in: MANAGEDCONTEXT)!
    

}
