//
//  ProductCartItem+CoreDataProperties.swift
//  new
//
//  Created by Иван Котляр on 25.02.2022.
//
//

import Foundation
import CoreData


extension ProductCartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCartItem> {
        return NSFetchRequest<ProductCartItem>(entityName: "ProductCartItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var product_id: NSNumber?
    @NSManaged public var price: NSNumber?
    @NSManaged public var image: String?
    @NSManaged public var quantity: NSNumber?

}

extension ProductCartItem : Identifiable {

}
