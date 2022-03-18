//
//  CartView.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @StateObject var fm = formaterr()
    @ObservedObject var netManager: NetworkManager
    @StateObject var ViewModel: CartViewModel
    init(netManager: NetworkManager){
        self.netManager = netManager
        _ViewModel = StateObject(wrappedValue: CartViewModel(netManager: netManager))
    }
    var body: some View {
        NavigationView {
            VStack {
                List(){
                    if let carts = ViewModel.cart {
                        if let products = carts.products {
                            ForEach(products) { (cartItem: ProductResponse) in
                                CartItemView(cartItem: cartItem, ViewModel: ViewModel)
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
                            .font(.wineSubTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        Spacer()
                        if let carts = ViewModel.cart {
                            Text("\(fm.priceFormat(price: carts.total)) &#8381;")
                                .font(.wineSubTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        } else {
                            Text("0 &#8381;")
                                .font(.wineSubTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    Button(action:{}){
                        Text("Оформить заказ")
                            .font(.wineSubTitle)
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
    let cartItem: ProductResponse
    @ObservedObject var ViewModel: CartViewModel
    @StateObject var fm = formaterr()
    @State var quantity: Int = 1
    var body: some View {
        HStack(spacing: 15){
            VStack {
                WebImage(url: URL(string: cartItem.thumb))
                    .onSuccess { image, data, cacheType in
                    }
                    .resizable()
                    .placeholder(Image(systemName: "photo"))
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
            }
            .frame(height: 120)
            VStack(alignment: .leading, spacing: 10) {
                Text(cartItem.name)
                    .font(.wineDefault)
                    .fontWeight(.medium)
                    .foregroundColor(Color("title"))
                Text(cartItem.name_alt)
                    .font(.wineNameAlt)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                HStack(spacing: 15){
                    let price = fm.priceFormat(price: cartItem.price)
                    Text("\(price) &#8381;")
                        .font(.wineSubTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                    Button(action: {
                        if quantity > 1 {
                            quantity = quantity - 1
                            ViewModel.updateQuantityProductCart(cartId: cartItem.cartId, quantity: quantity)
                        }
                    }){
                        Image(systemName: "minus")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    Text("\(quantity)")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical,5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.06))
                    Button(action: {
                        quantity = quantity + 1
                        ViewModel.updateQuantityProductCart(cartId: cartItem.cartId, quantity: quantity)
                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            Button(action: {
                ViewModel.deleteProductFromCart(cartId: cartItem.cartId)
            }){
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
                Text("Удалить")
            }
            .tint(.red)
            Button(action: {
                //Тут будет добавление в избранное (Для Максима)
            }) {
                Image(systemName: "heart")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
                Text("Избранное")
            }
            .tint(.blue)
        }
        .padding()
        .onAppear{
            self.quantity = cartItem.quantity
        }
    }
}
