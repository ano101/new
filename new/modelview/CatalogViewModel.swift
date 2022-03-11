//
//  CatalogViewModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

class CatalogViewModel: ObservableObject {
    let model = CatalogModel()
    @Published var categorys: [Category] = []
    
    func getCaterogys(){
        model.getCatalog { (category) in
            self.categorys = category
        }
    }
}
