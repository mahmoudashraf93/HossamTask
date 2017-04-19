//
//  Item+CoreDataProperties.swift
//  
//
//  Created by mahmoud salah on 4/10/17.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var title: String?
    @NSManaged public var timeStamp: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var image: NSData?
    @NSManaged public var isLiked: Bool
    @NSManaged public var ownerName: String?
    @NSManaged public var ownerImage: NSData?

}
