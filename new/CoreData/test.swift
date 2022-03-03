//
//  test.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import SwiftUI

struct test: View {
    
    let codeDM: CoreDataManager
    @State private var productName: String = ""
    @State private var products: [ProductCartItem] = [ProductCartItem]()
    var body: some View {
        NavigationView {
            VStack {
                TextField("Введите имя", text: $productName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save"){
                    //codeDM.saveProduct(name: "Тест", product_id: 123, price: 123, image: "Картинка")
                }
                
                List(products, id: \.self){ product in
                    Text(String(describing: product.product_id ?? 0 ))
                    Text("\(product.quantity ?? 0)")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Товары")
            .onAppear {
               products = codeDM.getAllCartProducts()
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test(codeDM: CoreDataManager())
    }
}
