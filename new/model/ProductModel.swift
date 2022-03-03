//
//  ProductModel.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import Foundation

struct ProductItem: Codable, Identifiable {
    let id = UUID()
    let product_id: Int
    let name: String
    let price: Int
    let image: String
}

class ProductModel: ObservableObject {
    
    let product_id: Int
    
    init(product_id: Int){
        self.product_id = product_id
    }
    
    func getProduct(product_id: Int, completion: @escaping ([ProductItem]) -> ()){
        guard let url = URL(string: "https://winerow.ru/attr/api3.php?product_id=\(product_id)") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let products = try JSONDecoder().decode([ProductItem].self, from: data)
                
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
