//
//  CartViewModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import Foundation
import CoreData

class CartViewModel: ObservableObject {

    let netManager: NetworkManager
    
    @Published var cart: CartItem?

    init(netManager: NetworkManager){
        self.netManager = netManager
    }

    func getCartProducts(){
        if
            let customer_id = UserDefaults.standard.string(forKey: "user_id"),
            let hash = UserDefaults.standard.string(forKey: "hash"
        ){
            self.netManager.showLoaderApi = true
            let postBody = SendGetCart(hash: hash, customer_id: customer_id)
            netManager.postItem(for: "api/mob/getCart", body: postBody) { (cart: CartItem) in
                if cart.status == true {
                    self.cart = cart
                } else {
                    if cart.products == nil {
                        self.cart = nil
                    }
                    if let error = cart.error {
                        self.netManager.showSheetError = true
                        self.netManager.errorMessage = error
                    }
                }
                
                self.netManager.showLoaderApi = false
            }
        }
    }
    
    func deleteProductFromCart(cartId: Int){
        if let hash = UserDefaults.standard.string(forKey: "hash"), let customer_id =  UserDefaults.standard.string(forKey: "user_id") {
            let postBody = CartRemove(cartId: cartId, hash: hash, customer_id: customer_id)
            netManager.postItem(for: "api/mob/delCartProduct", body: postBody) { (cart: DefaultResponse) in
                if cart.status == false {
                    if let error = cart.error {
                        self.netManager.showSheetError = true
                        self.netManager.errorMessage = error
                    }
                }
                self.getCartProducts()
            }
        }
    }
    
    func updateQuantityProductCart(cartId: Int, quantity: Int){
        if let hash = UserDefaults.standard.string(forKey: "hash"), let customer_id =  UserDefaults.standard.string(forKey: "user_id") {
            let postBody = SendQuantityProductCart(cartId: cartId, quantity: quantity, hash: hash, customer_id: customer_id)
            netManager.postItem(for: "api/mob/updateCartProduct", body: postBody) { (cart: DefaultResponse) in
                if cart.status == false {
                    if let error = cart.error {
                        self.netManager.showSheetError = true
                        self.netManager.errorMessage = error
                    }
                }
                self.getCartProducts()
            }
        }
    }
    
}
