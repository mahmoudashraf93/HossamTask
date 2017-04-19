//
//  ItemUtilityClass.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/9/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit
import CoreData

class ItemUtilityClass: NSObject {
    
    static let sharedInstance: ItemUtilityClass = {
        let instance = ItemUtilityClass()
        
        // setup code
        
        return instance
    }()
    
    
    func getAllItems() -> [Item] {
        let managedContext =
            Constants.APPDELEGATE.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        var items: Array<Item> = []
        
        do {
            items = try managedContext.fetch(fetchRequest)
            
            for _ in items {
            }
            
            return items
        } catch {
            
        }
        return items
        
    }
    
    func favoriteItem(itemToFav : Item)  {
        let managedContext =
            Constants.APPDELEGATE.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        var items: Array<Item> = []
        
        do {
            items = try managedContext.fetch(fetchRequest)
            
            for item in items {
                if item == itemToFav {
                    item.isLiked = true
                }
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
        } catch {
            
        }
        
    }
    
    func unfavoriteItem(itemToUnFav : Item)  {
        let managedContext =
            Constants.APPDELEGATE.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        var items: Array<Item> = []
        
        do {
            items = try managedContext.fetch(fetchRequest)
            
            for item in items {
                if item == itemToUnFav {
                    item.isLiked = false
                }
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
        } catch {
            
        }
        
    }
    
    func removeItem(itemToRemove : Item)  {
        let managedContext =
            Constants.APPDELEGATE.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        var items: Array<Item> = []
        
        do {
            items = try managedContext.fetch(fetchRequest)
            
            for item in items {
                if item == itemToRemove {
                    managedContext.delete(item)
                }
            }
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
        } catch {
            
        }
        
    }
    
    
    func addItem(ItemToAdd: Item) {
        
        
        
        let item = Item(entity: Constants.ENTITY,
                        insertInto: Constants.MANAGEDCONTEXT)
        
        item.title = ItemToAdd.title
        item.timeStamp = ItemToAdd.timeStamp
        item.details = ItemToAdd.details
        
        item.image = ItemToAdd.image
        item.isLiked = ItemToAdd.isLiked
        item.ownerName = ItemToAdd.ownerName
        item.ownerImage = ItemToAdd.ownerImage
        // 4
        do {
            try Constants.MANAGEDCONTEXT.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func saveToCoreData(){
        do {
            try Constants.MANAGEDCONTEXT.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func saveDummyData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Item",
                                       in: managedContext)!
        
        let item = Item(entity: entity,
                        insertInto: managedContext)
        item.title = "masa2 el 3asal"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
        let date = dateFormatter.date(from: "2014-07-15 06:55:14.198000+00:00")
        item.timeStamp = date as NSDate?
        item.details = "3asall"
        if let img = UIImage(named: "1.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item.image = data
            
        }
        
        item.isLiked = false
        item.ownerName = "mahmoud"
        if let img = UIImage(named: "1.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item.ownerImage = data
            
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        let item1 = Item(entity: entity,
                         insertInto: managedContext)
        item1.title = "masa2 el foll"
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
        let date1 = dateFormatter.date(from: "2015-07-15 06:55:14.198000+00:00")
        item1.timeStamp = date1 as NSDate?
        item1.details = "foll"
        if let img = UIImage(named: "2.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item1.image = data
            
        }
        
        item1.isLiked = false
        item1.ownerName = "hossam"
        if let img = UIImage(named: "2.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item1.ownerImage = data
            
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        let item2 = Item(entity: entity,
                         insertInto: managedContext)
        
        item2.title = "masa2 el gamal"
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
        let date2 = dateFormatter.date(from: "2016-09-15 06:55:14.198000+00:00")
        item2.timeStamp = date2 as NSDate?
        item2.details = "gamal"
        if let img = UIImage(named: "3.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item2.image = data
            
        }
        
        item2.isLiked = false
        item2.ownerName = "7ouda"
        if let img = UIImage(named: "3.jpg") {
            let data = UIImagePNGRepresentation(img) as NSData?
            item2.ownerImage = data
            
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        // addItem(ItemToAdd: item)
        
    }
    
    func getAllFavorites() -> [Item]{
        
        var favArray : Array<Item> = []
        
        for item in self.getAllItems() {
            
            if item.isLiked {
                
                favArray.append(item)
                
            }
            
        }
        
        return favArray
        
        
    }
    
    func getAllUserItems() -> [Item]{
        
        var userItemsArray : Array<Item> = []
        
        for item in self.getAllItems() {
            
            if item.ownerName == UserUtilityClass.sharedInstance.getUser().name {
                
                userItemsArray.append(item)
                
            }
            
        }
        
        return userItemsArray
        
        
    }
    
    func timeAgoSinceDate(_ date:Date, numericDates:Bool) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        
        
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
}
