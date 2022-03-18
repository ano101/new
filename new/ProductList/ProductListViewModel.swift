//
//  ProductListViewModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

class ProductListViewModel: ObservableObject {
    let categoryId: Int
    @Published var products: [Product] = []
    var newPageToLoad = 1
    var currentlyLoading = false
    var doneLoading = false
    var urlBase: String
    let netManager: NetworkManager
    
    init(categoryId: Int, netManager: NetworkManager){
        self.netManager = netManager
        self.categoryId = categoryId
        urlBase = "api/mob/getListProducts&cate_id=\(categoryId)&page="
    }
    
    func getProducts(currentItem: Product? = nil){
        if !shouldLoadMoreData(currentItem: currentItem){
            return
        }
        let url = "\(urlBase)\(newPageToLoad)"
        print(url)
        netManager.getItem(for: url) { (product: ProductList) in
            if product.status {
                if let productsList = product.product {
                    self.products.append(contentsOf: productsList)
                    self.doneLoading = (productsList.count == 0)
                } else {
                    self.doneLoading = true
                }
            } else {
                if let error = product.error {
                    self.netManager.errorMessage = error
                    self.netManager.showSheetError = true
                }
            }
        }
        self.newPageToLoad += 1
        self.currentlyLoading = false
    }
    
    func shouldLoadMoreData(currentItem: Product? = nil ) -> Bool{
        if currentlyLoading || doneLoading {
            return false
        }
        guard let currentItem = currentItem else {
            return true
        }
        for N in (products.count - 4)...(products.count-1) {
            if N >= 0 && currentItem.id == products[N].id {
                return true
            }
        }
        return false
    }
}
