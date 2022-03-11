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
    @FocusState private var nameIsFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(product_id: Int){
        self.product_id = product_id
        _ViewModel = StateObject(wrappedValue: ProductViewModel(product_id: product_id))
    }

        var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    var body: some View {
        
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
                            .frame(height: 200)
                    }
                    
                    Text("\(product.name)")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .font(.custom("Montserrat", size: 16))
                        .padding(.top, 5.0)
                        .foregroundColor(Color("title"))
                    
                    
                    Text("\(product.name_alt)")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .font(.custom("Montserrat", size: 12))
                        .padding(.top, 0.1)
                    
                    
                    
                    VStack{
                        VStack{
                            HStack{
                                if special > 0 {
                                    
                                    Text("\(special) &#8381;")
                                        .font(.custom("Montserrat", size: 17))
                                        .fontWeight(.semibold)
                                    Text("\(product.price) &#8381;")
                                        .font(.custom("Montserrat", size: 17))
                                        .fontWeight(.semibold)
                                        .strikethrough(true)
                                    
                                } else {
                                    Text("\(product.price) &#8381;")
                                        .font(.custom("Montserrat", size: 17))
                                        .fontWeight(.semibold)
                                }
                                
                            }
                            if let discounts = product.discounts {
                                ForEach(discounts){ (discount: DiscountsProduct) in
                                    Text("От \(discount.quantity) шт: \(discount.price) &#8381;")
                                        .font(.custom("Montserrat", size: 13))
                                        .fontWeight(.medium)
                                }
                            }
                            
                            Divider()
                            HStack {
                                Text("\(product.price2) &#8381;")
                                    .font(.custom("Montserrat", size: 16))
                                Image(systemName: "creditcard.circle.fill")
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                    .foregroundColor(Color("primary"))
                            }
                            
                            
                            if product.quantity <= 0 && product.stock_status_id == 5 {
                                Text("\(product.stock_status)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                                    .font(.custom("Montserrat", size: 16))
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
                                            .frame(width: 30)
                                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .font(.custom("Montserrat", size: 16))
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
//                                        ViewModel.save(name: product.name, product_id: product.product_id, price: product.price, quantity: quantity, image: product.image!)
                                        ViewModel.addToCart(product_id: product.product_id, quantity: quantity)
                                    }){
                                        HStack {
                                            Image(systemName: "bag.badge.plus")
                                                .foregroundColor(Color.white)
                                            Text("В корзину")
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .font(.custom("Montserrat", size: 16))
                                            
                                        }
                                        .padding(.all, 7.0)
                                        .frame(maxWidth: .infinity)
                                        .background(Color("primary"))
                                        
                                        
                                    }
                                }
                                Text("Артикул: \(String(product.product_id))")
                                    .foregroundColor(Color.gray)
                                    .font(.custom("Montserrat", size: 13))
                                    .padding(.all,1)
                                if product.quantity > 0 {
                                    Text("В магазине")
                                        .font(.custom("Montserrat", size: 16))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(hue: 0.241, saturation: 0.932, brightness: 0.626))
                                } else {
                                    Text("\(product.stock_status)")
                                        .font(.custom("Montserrat", size: 16))
                                        .fontWeight(.semibold)
                                    
                                    if product.stock_status_id == 8 {
                                        Text("Цену и наличие нужно уточнять!")
                                            .foregroundColor(.red)
                                            .font(.custom("Montserrat", size: 14))
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 0.1)
                                        Text("Перемещение товара со склада занимает 2-3 рабочих дня!")
                                            .foregroundColor(.red)
                                            .font(.custom("Montserrat", size: 14))
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
                                ForEach(attributes){ (attribut: AttributesProduct) in
                                    HStack {
                                        Text("\(attribut.name)")
                                            .font(.custom("Montserrat", size: 14))
                                        Spacer()
                                        Text("\(attribut.text)")
                                            .font(.custom("Montserrat", size: 14))
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
                self.ViewModel.getProduct(product_id: product_id)
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
                // Hide the system back button
                .navigationBarBackButtonHidden(true)
                // Add your custom back button here
                .navigationBarItems(leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                            
                        }
                })
    }
       
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProductView(product_id: 187836388)
        }
        
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "1" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

