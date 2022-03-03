//
//  ProductListView.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import SwiftUI

struct ProductListView: View {
    
    var catid: Int
    var namecat: String
    @State private var showText = true
    @ObservedObject var model: ProductsFeed

    @State var showCardPoup: Bool = false
    
    init(catid: Int, namecat: String){
        self.catid = catid
        self.namecat = namecat
        self.model = ProductListViewModel(catid: catid).model
    }
    
    
    public var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 15),
    ]
    var body: some View {
        
        
        ScrollView {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(model) { (product: Product) in
                        ProductItemView(product: product, showCardPoup: $showCardPoup, model: model)
                            .onAppear {
                                self.model.loadMoreProducts(currentItem: product)
                            }
                    }
                    
                }
                .onAppear(){
                    // self.model.loadMoreProducts()
                }
                
                
                .sheet(isPresented: $showCardPoup, content: {
                    CardPoup()
                })
                
                
                
                
            }
        }.navigationTitle(Text("\(namecat)"))
    }
}

struct ProductItemView: View {
    var product: Product
    @Binding var showCardPoup: Bool
    var model: ProductsFeed
    @State private var stroken = true
    public var gridItemLayout = [GridItem(.adaptive(minimum: 10), spacing: 10)]
    var body: some View {
        let special = product.special ?? 0
        
        ZStack {
            
            VStack(spacing:10){
                ZStack(alignment: .top){
                    if special > 0 {
                        HStack() {
                            
                            Text("Акция")
                                .fontWeight(.semibold)
                                .padding(3)
                                .background(Color("primary"))
                                .font(.custom("Montserrat", size: 10))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .zIndex(10)
                    }
                    
                    NavigationLink(destination: ProductView(product_id: product.product_id)) {
                        ImageView(urlString: product.image)
                            .zIndex(9)
                    }
                    .frame(height: 120)
                }
                
                
                Text("\(product.name)")
                    .font(.custom("Montserrat", size: 13))
                    .lineLimit(3)
                
//                if let attributes = product.attributes {
//                    WrappingHStack(attributes, id:\.self, alignment: .center, spacing: .constant(7)) { (atr: Attributes) in
//                        Text("\(atr.value)")
//                            .fontWeight(.light)
//                            .font(.custom("Montserrat", size: 10))
//                    }.frame(maxWidth: 250)
//                }
                
                if let price2 = product.price2 {
                    HStack() {
                        Text("\(price2) &#8381;")
                            .fontWeight(.semibold)
                            .font(.custom("Montserrat", size: 14))
                    }
                    Divider()
                }
                
                HStack{
                    
                    VStack {
                        if special > 0 {
                            Text("\(special) &#8381;")
                                .fontWeight(.semibold)
                                .font(.custom("Montserrat", size: 14))
                                .foregroundColor(Color("primary"))
                            
                            Text("\(product.price) &#8381;")
                                .fontWeight(.semibold)
                                .font(.custom("Montserrat", size: 14))
                                .strikethrough(stroken)
                                .onTapGesture(perform: {
                                    self.stroken.toggle()
                                })
                        } else {
                            Text("\(product.price) &#8381;")
                                .fontWeight(.semibold)
                                .font(.custom("Montserrat", size: 14))
                        }
                    }
                    Button(action: {
                        showCardPoup.toggle()
                        
                    }){
                        Image(systemName: "creditcard.circle.fill")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .foregroundColor(Color("primary"))
                    }
                    
                    
                }
                
                if product.quantity > 0 {
                    Text("В магазине")
                        .fontWeight(.semibold)
                        .font(.custom("Montserrat", size: 10))
                } else {
                    Text("\(product.stock_status)")
                        .fontWeight(.semibold)
                        .font(.custom("Montserrat", size: 10))
                }
               
                    NavigationLink(destination: ProductView(product_id: product.product_id)){
                        Text("Подробнее")
                            .font(.custom("Montserrat", size: 14))
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

struct ProductListView_Previews: PreviewProvider {
    var catid: String
    var namecat: String
    static var previews: some View {
        ProductListView(catid: 8661540, namecat: "123")
    }
}
