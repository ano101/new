//
//  CatalogView.swift
//  new
//
//  Created by Иван Котляр on 17.02.2022.
//

import SwiftUI

struct CatalogView: View {
   @StateObject var viewModel = CatalogViewModel()
    @State var categorys: [Category] = []
    init(){
          //UITableView.appearance().backgroundColor = .clear
        }
    var body: some View {
        NavigationView {
            List(categorys) { category in
                        NavigationLink(destination: ProductListView(catid: category.category_id, namecat: category.name)) {
                            Text(category.name)
                                .font(.custom("Montserrat", size: 18))
                                .multilineTextAlignment(.leading)
                               .padding(.top, 10.0)
                    }
            }.listStyle(InsetListStyle())
            .navigationTitle(
                Text("Каталог")
            )
            .onAppear {
                viewModel.model.getCatalog { (categorys) in
                    self.categorys = categorys
                }
            }
        }
}
}
struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
