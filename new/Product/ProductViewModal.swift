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
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    let netManager: NetworkManager
    let product_id: Int
    init(product_id: Int, netManager: NetworkManager){
        self.product_id = product_id
        self.netManager = netManager
    }
    
    func addToCart(quantity: Int){
        if let customer = UserDefaults.standard.string(forKey: "user_id"), let hash = UserDefaults.standard.string(forKey: "hash"){
            let addProduct = AddProductStruct(customer_id: customer, hash: hash, product_id: product_id, quantity: quantity)
            netManager.postItem(for: "api/mob/addToCart", body: addProduct) { (product: ResponseAddProduct) in
                if product.status {
                    if let message = product.alert {
                        self.showAlert = true
                        self.alertMessage = message
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.showAlert = false
                        }
                    } else {
                        if let error = product.error {
                            self.netManager.errorMessage = error
                            self.netManager.showSheetError = true
                        }
                    }
                }
            }
        }
    }
    
    func getProduct() {
        netManager.getItem(for: "api/mob/getProduct&prod_id=\(product_id)") { (product: ProductItem) in
            print(product)
            if product.status {
                self.products = product
            } else {
                if let error = product.error {
                    self.netManager.errorMessage = error
                    self.netManager.showSheetError = true
                }
            }
        }
    }
}

