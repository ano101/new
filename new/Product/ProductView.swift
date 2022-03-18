//
//  ProductView.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct ProductView: View {
    let product_id: Int
    @State private var quantity = 1
    @StateObject var ViewModel: ProductViewModel
    @ObservedObject var netManager: NetworkManager
    @FocusState private var nameIsFocused: Bool
    
    
    init(product_id: Int, netManager: NetworkManager){
        self.product_id = product_id
        self.netManager = netManager
        _ViewModel = StateObject(wrappedValue: ProductViewModel(product_id: product_id, netManager: netManager))
    }
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                    if let product = ViewModel.products {
                        let special = product.special ?? 0
                        if let image = product.image {
                            WebImage(url: URL(string: image))
                                .onSuccess { image, data, cacheType in
                                }
                                .resizable()
                                .placeholder(Image(systemName: "photo"))
                                .indicator(.activity)
                                .transition(.fade(duration: 0.5))
                                .scaledToFit()
                                .frame(height: 220)
                        }
                        Text("\(product.name)")
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .font(.wineSubTitle)
                            .padding(.top, 5.0)
                            .foregroundColor(Color("title"))
                        
                        Text("\(product.name_alt)")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                            .font(.wineNameAlt)
                            .padding(.top, 0.1)
                        VStack{
                            VStack{
                                HStack{
                                    if special > 0 {
                                        Text("\(special) &#8381;")
                                            .font(.wineProductPrice)
                                            .fontWeight(.semibold)
                                        Text("\(product.price) &#8381;")
                                            .font(.wineProductPrice)
                                            .fontWeight(.semibold)
                                            .strikethrough(true)
                                    } else {
                                        Text("\(product.price) &#8381;")
                                            .font(.wineProductPrice)
                                            .fontWeight(.semibold)
                                    }
                                }
                                if let discounts = product.discounts {
                                    ForEach(discounts){ (discount: DiscountsProduct) in
                                        Text("От \(discount.quantity) шт: \(discount.price) &#8381;")
                                            .font(.wineProductDiscount)
                                            .fontWeight(.medium)
                                    }
                                }
                                Divider()
                                HStack {
                                    Text("\(product.price2) &#8381;")
                                        .font(.wineSubTitle)
                                    Image(systemName: "creditcard.circle.fill")
                                        .resizable()
                                        .frame(width: 25.0, height: 25.0)
                                        .foregroundColor(Color("primary"))
                                }
                                if product.quantity <= 0 && product.stock_status_id == 5 {
                                    Text("\(product.stock_status)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.white)
                                        .font(.wineSubTitle)
                                        .padding(.all, 7.0)
                                        .frame(maxWidth: .infinity)
                                        .background(Color("primary"))
                                } else {
                                    HStack {
                                        HStack{
                                            Button(action: {
                                                if quantity > 1 {
                                                    quantity = quantity - 1
                                                }
                                            }){
                                                Image(systemName: "minus")
                                                    .font(.system(size: 16, weight: .heavy))
                                                    .foregroundColor(.black)
                                            }
                                            TextField("1", value: $quantity, formatter: NumberFormatter())
                                                .focused($nameIsFocused)
                                                .keyboardType(.numberPad)
                                                .frame(width: 60)
                                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .font(.wineSubTitle)
                                                .toolbar {
                                                    ToolbarItemGroup(placement: .keyboard) {
                                                        Button("Готово"){
                                                            nameIsFocused = false
                                                        }
                                                    }
                                                }
                                            Button(action: {
                                                quantity = quantity + 1
                                            }){
                                                Image(systemName: "plus")
                                                    .font(.system(size: 16, weight: .heavy))
                                                    .foregroundColor(.black)
                                            }
                                            
                                        }
                                        .padding(.all, 7.0)
                                        .background(.white)
                                        
                                        Button(action: {
                                            nameIsFocused = false
                                            ViewModel.addToCart(quantity: quantity)
                                        }){
                                            HStack {
                                                Image(systemName: "bag.badge.plus")
                                                    .foregroundColor(Color.white)
                                                Text("В корзину")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.white)
                                                    .font(.wineSubTitle)
                                            }
                                            .padding(.all, 7.0)
                                            .frame(maxWidth: .infinity)
                                            .background(Color("primary"))
                                        }
                                    }
                                    Text("Артикул: \(String(product.product_id))")
                                        .foregroundColor(Color.gray)
                                        .font(.wineProductDiscount)
                                        .padding(.all,1)
                                    if product.quantity > 0 {
                                        Text("В магазине")
                                            .font(.wineSubTitle)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(hue: 0.241, saturation: 0.932, brightness: 0.626))
                                    } else {
                                        Text("\(product.stock_status)")
                                            .font(.wineSubTitle)
                                            .fontWeight(.semibold)
                                        if product.stock_status_id == 8 {
                                            Text("Цену и наличие нужно уточнять!")
                                                .foregroundColor(.red)
                                                .font(.wineDefault)
                                                .multilineTextAlignment(.center)
                                                .padding(.top, 0.1)
                                            Text("Перемещение товара со склада занимает 2-3 рабочих дня!")
                                                .foregroundColor(.red)
                                                .font(.wineDefault)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color("backgrey"))
                            if let attributes = product.attributes {
                                Text("Характеристики:")
                                VStack(spacing: 10){
                                    ForEach(attributes){ attribut in
                                        HStack {
                                            Text("\(attribut.name)")
                                                .font(.wineDefault)
                                            Spacer()
                                            Text("\(attribut.text)")
                                                .font(.wineDefault)
                                        }
                                    }
                                }
                                .padding(.top,5)
                            }
                        }
                        .padding(.top, 10.0)
                    }
                }
                .padding([.leading, .bottom, .trailing])
                .onAppear {
                    self.ViewModel.getProduct()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            if ViewModel.showAlert {
                if let message = ViewModel.alertMessage {
                    VStack {
                        Text("\(message)")
                            .font(.wineTitle)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.all, 5)
                            .background(Color("primary"))
                    }
                    .zIndex(10)
                    .frame(height: 33)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .transition(.move(edge: .top))
                    .animation(.spring())
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    let netManager = NetworkManager()
    static var previews: some View {
        ZStack {
            ProductView(product_id: 187836388, netManager: NetworkManager())
        }
        
    }
}
