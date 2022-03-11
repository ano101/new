//
//  ProductViewModal.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    @Published var products: ProductItem?
    let model: ProductModel
    let product_id: Int
    init(product_id: Int){
        self.product_id = product_id
        self.model = ProductModel(product_id: product_id)
    }
    
//    func save(name: String, product_id: Int, price: Int, quantity: Int, image: String){
//        let product = ProductCartItem(context: CoreDataManager.shared.viewContext)
//        product.name = name
//        product.product_id = NSNumber(value: product_id)
//        product.price = NSNumber(value: price)
//        product.quantity = NSNumber(value: quantity)
//        product.image = image
//        CoreDataManager.shared.save()
//    }
    
    func addToCart(product_id: Int, quantity: Int){
        if let customer = UserDefaults.standard.string(forKey: "user_id"), let hash = UserDefaults.standard.string(forKey: "hash"){
            let struct2 = AddProductStruct(customer_id: customer, hash: hash, product_id: product_id, quantity: quantity)
            model.addProduct(body: struct2) { (result) in
                
            }
        }
        
    }
    
//    func checkProductInCart(product_id: Int) -> Bool {
//        let exProduct = CoreDataManager.shared.getProductByProductId(product_id: product_id)
//        if exProduct != false {
//            return true
//        } else {
//            return false
//        }
//    }
    
    func getProduct(product_id: Int) {
        
        model.getProduct(product_id: product_id) { (products) in
            self.products = products
        }
        
    }
}

