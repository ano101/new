//
//  CartViewModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import Foundation
import CoreData

class CartListViewModel: ObservableObject {
    
    @Published var products: [CartViewModel] = []
    
    func getCartProducts(){
        products = CoreDataManager.shared.getAllProducts().map(CartViewModel.init)
    }
    
    func delCartProducts(_ product: CartViewModel){
        let existingProduct = CoreDataManager.shared.getProductById(id: product.id)
        if let existingProduct = existingProduct {
            CoreDataManager.shared.deleteProduct(product: existingProduct)
        }
        
    }
    
    func updateCartProducts(product: ProductViewState) {
        do {
            try CoreDataManager.shared.updateProduct(product)
        } catch {
            print("Error update product in cart \(error)")
        }
    }
    
}

struct CartViewModel {
    
    var product: ProductCartItem
    
    var id: NSManagedObjectID {
        return product.objectID
    }
    
    var name: String {
        return product.name ?? ""
    }
    
    var image: String {
        return product.image ?? ""
    }
    
    var price: Int {
        return Int(product.price ?? 0)
    }
    
    var quantity: Int {
        return Int(product.quantity ?? 0)
    }
    
    var product_id: Int {
        return Int(product.product_id ?? 0)
    }
    
    
}
