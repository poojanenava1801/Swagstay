//
//  Product+CoreDataProperties.swift
//  
//
//  Created by mac on 16/03/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productName: String?
    @NSManaged public var price: String?
    @NSManaged public var productWeight: String?
    @NSManaged public var quantity: String?
    @NSManaged public var productImage: String?
    @NSManaged public var productWeightGram: String?
    @NSManaged public var productWeightCount: String?
    @NSManaged public var uom: String?
    @NSManaged public var product: String?

}

