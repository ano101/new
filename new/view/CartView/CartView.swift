//
//  CartView.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import SwiftUI

struct CartView: View {
    @StateObject var ViewModel = CartViewModel()
    @StateObject var fm = formaterr()
    var body: some View {
        NavigationView {
            VStack {
                List(){
                    if let carts = ViewModel.cart {
                        if let products = carts.products {
                            
                            ForEach(products) { (cartitem: ProductResponse) in
                                CartItemView(cartitem: cartitem, ViewModel: ViewModel)
                                
                            }
                        }
                       
                    }
                   
                }
                .listStyle(InsetListStyle())
                .onAppear(){
                    ViewModel.getCartProducts()
                }
                
                VStack {
                    HStack {
                        Text("Итого")
                            .font(.custom("Montserrat", size: 16))
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        Spacer()
                        if let carts = ViewModel.cart {
                            Text("\(fm.priceFormat(price: carts.total))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        } else {
                            Text("0")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Button(action:{}){
                        Text("Оформить заказ")
                            .font(.custom("Montserrat", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10.0)
                            .frame(width: UIScreen.main.bounds.width - 15)
                            .background(
                                LinearGradient(gradient: .init(colors:[Color.purple, Color("primary")]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                    }
                    .padding(.bottom)
                }
                .background(Color.white)
                
            }
            .navigationTitle("Корзина")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}



struct CartItemView: View {
    let cartitem: ProductResponse
    @ObservedObject var ViewModel: CartViewModel
    @StateObject var fm = formaterr()
 
    var body: some View {
        
        HStack(spacing: 15){
            ImageView(urlString: cartitem.thumb)
                .frame(width: 50, height: 90)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(cartitem.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack(spacing: 15){
                    let pricee = fm.priceFormat(price: cartitem.price)
                    Text("\(pricee) &#8381;")
                        .font(.custom("Montserrat", size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if cartitem.quantity > 1 {

                        }
                        
                    }){
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    Text("\(cartitem.quantity)")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical,5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.06))
                    
                    Button(action: {

                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
                
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            
            Button(action: {
                ViewModel.delProd(cart_id: cartitem.cart_id)
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
                Text("Удалить")
            }
            .tint(.red)
            
            Button(action: {
                
            }) {
                Image(systemName: "heart")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
                Text("Избранное")
            }
            .tint(.blue)
            
        }
        .padding()
    }
}
