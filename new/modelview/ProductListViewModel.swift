//
//  ProductListViewModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation



class ProductListViewModel: ObservableObject {
    let model: ProductsFeed
    let catid: Int
    @Published var products: [Product] = []
    
    init(catid: Int){
        self.catid = catid
        self.model = ProductsFeed(catid: catid)
    }
    
    func getProducts(currentItem: Product? = nil){
        let shouldLoadMore = shouldLoadMoreData(currentItem: currentItem)
        model.loadMoreProducts(currentItem: currentItem, shouldLoadMore: shouldLoadMore) { (products) in
            self.products.append(contentsOf: products)
        }
    }
    
    func shouldLoadMoreData(currentItem: Product? = nil ) -> Bool{
        guard let currentItem = currentItem else {
            return true
        }
        
        //TODO: For n ?)) Better naming. What is N?))
        for n in (products.count - 4)...(products.count-1) {
                    if n >= 0 && currentItem.id == products[n].id {
                        return true
                    }
                }
                return false
    }
    

}
