//
//  ProductListView.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListView: View {
    var categoryId: Int
    var nameCategory: String
    @State private var showText = true
    @StateObject var ViewModel: ProductListViewModel
    @ObservedObject var netManager: NetworkManager
    
    init(categoryId: Int, nameCategory: String, netManager: NetworkManager){
        self.categoryId = categoryId
        self.nameCategory = nameCategory
        self.netManager = netManager
        _ViewModel = StateObject(wrappedValue: ProductListViewModel(categoryId: categoryId, netManager: netManager))
    }
    
    public var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 15),
    ]
    
    var body: some View {
        ScrollView {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ViewModel.products) { (product: Product) in
                        ProductItemView(product: product, ViewModel: ViewModel, netManager: netManager)
                            .onAppear {
                                self.ViewModel.getProducts(currentItem: product)
                            }
                    }
                }
                .onAppear(){
                    self.ViewModel.getProducts()
                }
            }
        }.navigationTitle(Text("\(nameCategory)"))
    }
}

struct ProductItemView: View {
    var product: Product
    @ObservedObject var ViewModel: ProductListViewModel
    @ObservedObject var netManager: NetworkManager
    public var gridItemLayout = [GridItem(.adaptive(minimum: 10), spacing: 1)]
    var body: some View {
        let special = product.special ?? 0
        ZStack {
            VStack(spacing:10){
                ZStack(alignment: .top){
                    if special > 0 {
                        HStack {
                            Text("Акция")
                                .fontWeight(.semibold)
                                .padding(3)
                                .background(Color("primary"))
                                .font(.wineSpecialLabel)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .zIndex(10)
                    }
                    NavigationLink(destination: ProductView(product_id: product.product_id, netManager: netManager)) {
                        if let image = product.image {
                            WebImage(url: URL(string: image))
                                .onSuccess { image, data, cacheType in
                                    
                                }
                                .resizable()
                                .placeholder(Image(systemName: "photo"))
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFit()
                        }
                    }
                    .frame(height: 120)
                }
                Text("\(product.name)")
                    .font(.wineProductDiscount)
                    .lineLimit(3)
                if let attributes = product.attributes {
                    HWrapper(items: attributes)
                        .frame(maxWidth: 250)
                }
                if let price2 = product.price2 {
                    HStack {
                        Text("\(price2) &#8381;")
                            .fontWeight(.semibold)
                            .font(.wineDefault)
                    }
                    Divider()
                }
                HStack{
                    VStack {
                        if special > 0 {
                            Text("\(special) &#8381;")
                                .fontWeight(.semibold)
                                .font(.wineDefault)
                                .foregroundColor(Color("primary"))
                            
                            Text("\(product.price) &#8381;")
                                .fontWeight(.semibold)
                                .font(.wineDefault)
                                .strikethrough(true)
                        } else {
                            Text("\(product.price) &#8381;")
                                .fontWeight(.semibold)
                                .font(.wineDefault)
                        }
                    }
                    Button(action: {}){
                        Image(systemName: "creditcard.circle.fill")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .foregroundColor(Color("primary"))
                    }
                }
                if product.quantity > 0 {
                    Text("В магазине")
                        .fontWeight(.semibold)
                        .font(.wineSpecialLabel)
                } else {
                    Text("\(product.stock_status)")
                        .fontWeight(.semibold)
                        .font(.wineSpecialLabel)
                }
                NavigationLink(destination: ProductView(product_id: product.product_id, netManager: netManager)){
                    Text("Подробнее")
                        .font(.wineDefault)
                        .bold()
                }
                .frame(width: 140, height: 30, alignment: .center)
                .background(Color("primary"))
                .accentColor(.white)
            }
            .padding()
            //.frame(height: 280)
            
        }
    }
}

//struct ProductListView_Previews: PreviewProvider {
//    var catid: String
//    var namecat: String
//    static var previews: some View {
//        ProductListView(catid: 8661540, namecat: "123")
//    }
//}
