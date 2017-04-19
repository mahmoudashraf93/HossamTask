//
//  User+CoreDataProperties.swift
//  
//
//  Created by mahmoud salah on 4/10/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?

}
