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
    
    init(catid: Int){
        self.catid = catid
        self.model = ProductsFeed(catid: catid)
    }
    

}
