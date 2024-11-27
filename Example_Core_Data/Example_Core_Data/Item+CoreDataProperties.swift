//
//  Item+CoreDataProperties.swift
//  Example_Core_Data
//
//  Created by Mitya Kim on 11/26/24.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?

}

extension Item : Identifiable {

}
