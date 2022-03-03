//
//  CoreDataManager.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import Foundation
import CoreData
import SwiftUI

enum ProductError: Error {
    case productNotFound
}

class CoreDataManager: ObservableObject {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getAllProducts() -> [ProductCartItem] {
        let request: NSFetchRequest<ProductCartItem> = ProductCartItem.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print(0)
            return []
        }
    }
    
    func getProductById(id: NSManagedObjectID) -> ProductCartItem? {
        do {
            return try viewContext.existingObject(with: id) as? ProductCartItem
        } catch {
            return nil
        }
    }
    
   func getProductByProductId(product_id: Int) -> Bool {
       var res = false
       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCartItem")
        request.predicate = NSPredicate(format: "ANY product_id = %d", Int64(product_id))
        do {
            if let result = try viewContext.fetch(request) as? [ProductCartItem] {
            if result.count > 0{
                res =  true
            } else {
               res =  false
            }
            }
        } catch {
            
        }
       return res
    }
    
    func deleteProduct(product: ProductCartItem){
        viewContext.delete(product)
        save()
    }
    
    
    func updateProduct(_ vs: ProductViewState) throws {
        
        guard let id = vs.id else {
            throw ProductError.productNotFound
        }
        
        guard let product = getProductById(id: id) else {
            throw ProductError.productNotFound
        }
        
        product.name = vs.name
        product.image = vs.image
        product.price = NSNumber(value: vs.price)
        product.product_id = NSNumber(value: vs.product_id)
        product.quantity = NSNumber(value: vs.quantity)
        
        save()
    }
    
    func save(){
        do {
            try viewContext.save()
            print("Сохранено")
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "Cart")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
            
        }
    }
    

    

    

}

