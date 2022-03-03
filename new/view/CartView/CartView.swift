//
//  CartView.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import SwiftUI

struct CartView: View {
    @StateObject var cartLilstViewModel = CartListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(){
                    ForEach(cartLilstViewModel.products, id: \.id) { product in
                        CartItemView(product: product, cartLilstViewModel: cartLilstViewModel)
                        
                    }
                }
                .listStyle(InsetListStyle())
                .onAppear(){
                    cartLilstViewModel.getCartProducts()
                }
                
                VStack {
                    HStack {
                        Text("Итого")
                            .font(.custom("Montserrat", size: 16))
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                        Spacer()
                        
                        Text("5000")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
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
    let product: CartViewModel
    @ObservedObject var cartLilstViewModel: CartListViewModel
    @State private var productViewState = ProductViewState()
    
    
    private func update() {
        do {
            try cartLilstViewModel.updateCartProducts(product: productViewState)
        } catch {
            print("Error update caert \(error)")
        }
    }
    
    func deleteProduct() {
        cartLilstViewModel.delCartProducts(product)
        cartLilstViewModel.getCartProducts()
    }
    
    
    var body: some View {
        
        HStack(spacing: 15){
            ImageView(urlString: product.image)
                .frame(width: 50, height: 90)
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(product.name)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                HStack(spacing: 15){
                    Text("\(product.price) &#8381;")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if product.quantity > 1 {
                            productViewState.quantity = productViewState.quantity - 1
                            update()
                            cartLilstViewModel.getCartProducts()
                        }
                        
                    }){
                        Image(systemName: "minus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                    
                    Text("\(product.quantity)")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical,5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.06))
                    
                    Button(action: {
                        productViewState.quantity = productViewState.quantity + 1
                        update()
                        cartLilstViewModel.getCartProducts()
                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
                
            }
        }
        .onAppear(){
            productViewState = ProductViewState.fromCartViewModel(vm: product)
        }
        .buttonStyle(PlainButtonStyle())
        .swipeActions(edge: .trailing, allowsFullSwipe: true){
            
            Button(action: {
                deleteProduct()
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


