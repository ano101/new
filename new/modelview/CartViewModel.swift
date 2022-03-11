//
//  CartViewModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import Foundation
import CoreData

class CartViewModel: ObservableObject {
    let model = CartModel()
    @Published var cart: CartItem?
    //@Published var products: [CartViewModel] = []
    
//    func getCartProducts(){
//        products = CoreDataManager.shared.getAllProducts().map(CartViewModel.init)
//    }
    
    func getCartProducts(){
        if let hash = UserDefaults.standard.string(forKey: "hash"), let customer_id =  UserDefaults.standard.string(forKey: "user_id") {
            var body: [String: String] = ["hash": hash, "customer_id": customer_id]
            model.getProducts(body: body) { (cartitem) in
                if cartitem.status == true {
                    print("Корзина получена")
                    self.cart = cartitem
                } else {
                    print(cartitem.error)
                    print("Корзина clear")
                    self.cart = cartitem
                }
                
            }
        }
        
    }
    
    func delProd(cart_id: Int){
        if let hash = UserDefaults.standard.string(forKey: "hash"), let customer_id =  UserDefaults.standard.string(forKey: "user_id") {
            var body = CartRemove(cart_id: cart_id, hash: hash, customer_id: customer_id)
            model.delProd(body: body) { (cartitem) in
                if cartitem.status == true {
                    print("Товар из корзины удален")
                    self.getCartProducts()
                } else {
                    print(cartitem.error)
                }
            }
        }
    }
    
//    func delCartProducts(_ product: CartViewModel){
//        let existingProduct = CoreDataManager.shared.getProductById(id: product.id)
//        if let existingProduct = existingProduct {
//            CoreDataManager.shared.deleteProduct(product: existingProduct)
//        }
//
//    }
//
//    func updateCartProducts(product: ProductViewState) {
//        do {
//            try CoreDataManager.shared.updateProduct(product)
//        } catch {
//            print("Error update product in cart \(error)")
//        }
//    }
    
}

//struct CartViewModel {
//
//    var product: ProductCartItem
//
//    var id: NSManagedObjectID {
//        return product.objectID
//    }
//
//    var name: String {
//        return product.name ?? ""
//    }
//
//    var image: String {
//        return product.image ?? ""
//    }
//
//    var price: Int {
//        return Int(product.price ?? 0)
//    }
//
//    var quantity: Int {
//        return Int(product.quantity ?? 0)
//    }
//
//    var product_id: Int {
//        return Int(product.product_id ?? 0)
//    }
//
//
//}
