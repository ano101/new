//
//  ProductListView.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI
//import WrappingHStack

struct ProductListView: View {
    var catid: Int
    var namecat: String
    @State private var showText = true
    @StateObject var ViewModel: ProductListViewModel

    @State var showCardPoup: Bool = false
    
    init(catid: Int, namecat: String){
        self.catid = catid
        self.namecat = namecat
        _ViewModel = StateObject(wrappedValue: ProductListViewModel(catid: catid))
    }
    
    
    public var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 160), spacing: 15),
    ]
    var body: some View {
        
        
        ScrollView {
            ZStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ViewModel.products) { (product: Product) in
                        ProductItemView(product: product, showCardPoup: $showCardPoup, ViewModel: ViewModel)
                            .onAppear {
                                self.ViewModel.getProducts(currentItem: product)
                            }
                    }
                    
                }
                .onAppear(){
                    self.ViewModel.getProducts()
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
    @ObservedObject var ViewModel: ProductListViewModel
    public var gridItemLayout = [GridItem(.adaptive(minimum: 10), spacing: 1)]
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
//                        ImageView(urlString: product.image)
//                            .zIndex(9)
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
                    .font(.custom("Montserrat", size: 13))
                    .lineLimit(3)
                
                if let attributes = product.attributes {
                    TagsView(items: attributes)
                        .frame(maxWidth: 250)
//                    WrappingHStack {
//
//                    WrappingHStack(attributes, alignment: .center, spacing: .constant(7)) { (atr: Attributes) in
//                        Text("\(atr.value)")
//                            .fontWeight(.light)
//                            .font(.custom("Montserrat", size: 10))
//                    }.frame(maxWidth: 250)
//                    }
                }
                
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
                                .strikethrough(true)
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

struct TagsView: View {
    
    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [String]) -> [[String]] {
        
        var groupedItems: [[String]] = [[String]]()
        var tempItems: [String] =  [String]()
        var width: CGFloat = 0
        
        for word in items {
            
            let label = UILabel()
            label.text = word
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 32
            
            if (width + labelWidth + 55) < screenWidth {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
            
        }
        
        groupedItems.append(tempItems)
        return groupedItems
        
    }
    
    var body: some View {
       // ScrollView {
        VStack(alignment: .center) {
            
            ForEach(groupedItems, id: \.self) { subItems in
                HStack {
                    ForEach(subItems, id: \.self) { word in
                        Text(word)
                            .fontWeight(.light)
                            .font(.custom("Montserrat", size: 10))
                            .fixedSize()
                    }
                }
            }
            
            Spacer()
        }
            // }
    }
    
}
