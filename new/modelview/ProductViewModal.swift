//
//  ProductViewModal.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    let model: ProductModel
    let product_id: Int
    init(product_id: Int){
        self.product_id = product_id
        self.model = ProductModel(product_id: product_id)
    }
    
    func save(name: String, product_id: Int, price: Int, quantity: Int, image: String){
        let product = ProductCartItem(context: CoreDataManager.shared.viewContext)
        product.name = name
        product.product_id = NSNumber(value: product_id)
        product.price = NSNumber(value: price)
        product.quantity = NSNumber(value: quantity)
        product.image = image
        CoreDataManager.shared.save()
    }
    
    func checkProductInCart(product_id: Int) -> Bool {
        let exProduct = CoreDataManager.shared.getProductByProductId(product_id: product_id)
        if exProduct != false {
            return true
        } else {
            return false
        }
    }
}

