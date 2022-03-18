//
//  CatalogView.swift
//  new
//
//  Created by Иван Котляр on 17.02.2022.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject var netManager: NetworkManager
    @StateObject var viewModel: CatalogViewModel
    
    init(netManager: NetworkManager){
        self.netManager = netManager
        _viewModel = StateObject(wrappedValue: CatalogViewModel(netManager: netManager))
    }

    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: ProductListView(categoryId: category.category_id, nameCategory: category.name, netManager: netManager)) {
                    Text(category.name)
                        .font(.wineTitle)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10.0)
                }
            }.listStyle(InsetListStyle())
                .navigationTitle(
                    Text("Каталог")
                )
        }
        .onAppear {
            if !viewModel.doneLoading {
                viewModel.getCaterogies()
                viewModel.doneLoading = true
            }
            
        }
    }
}
//struct CatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatalogView()
//    }
//}
