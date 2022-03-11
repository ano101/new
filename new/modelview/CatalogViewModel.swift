//
//  CatalogViewModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

class CatalogViewModel: ObservableObject {
    let model = CatalogModel()
    @Published var categories: [Category] = []
    
    //TODO: Rename all incorrect naming
    func getCaterogys(){
        model.getCatalog { (category) in
            self.categories = category
        }
    }
}
