//
//  CatalogViewModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

class CatalogViewModel: ObservableObject {
    @Published var categories: [Category] = []
    var doneLoading: Bool = false
    let netManager: NetworkManager
    
    init(netManager: NetworkManager){
        self.netManager = netManager
    }
    
    func getCaterogies(){
        netManager.getItem(for: "api/mob/getCategories") { (category: CategoriesList) in
            if category.status{
                self.categories = category.categories
            } else {
                if let error = category.error {
                    self.netManager.showSheetError = true
                    self.netManager.errorMessage = error
                }
            }
        }
    }
}
