//
//  ProductView.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import SwiftUI


struct ProductView: View {
    var product_id: Int
    @State private var quantity: Int = 1
    @State var model: ProductModel
    @State var products: [ProductItem] = []
    @State var ViewModel: ProductViewModel
    
    init(product_id: Int){
        self.ViewModel = ProductViewModel(product_id: product_id)
        self.product_id = product_id
        self.model = ProductViewModel(product_id: product_id).model
    }
    
    var body: some View {
        ScrollView{
                    VStack {
                        ForEach(products){ (product: ProductItem) in
                            ImageView(urlString: product.image)
                                .frame(width: 90)
                            Text(product.name)
                                .padding()
                            Text("\(product.price) &#8381;")
                            TextField("Введите количество", value: $quantity, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button("Добавить в корзину") {
                                ViewModel.save(name: product.name, product_id: Int(product.product_id), price: Int(product.price), quantity: quantity, image: product.image)
                            }
                            
                            .frame(width: 200, height: 35, alignment: .center)
                            .background(Color("primary"))
                            .accentColor(.white)
                        }
                    }
            .onAppear {
                model.getProduct(product_id: product_id) { (products) in
                    self.products = products
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product_id: 187833040)
    }
}
