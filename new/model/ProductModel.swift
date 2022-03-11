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
    let name_alt: String
    let price: Int
    let quantity: Int
    let price2: Int
    let special: Int?
    let stock_status_id: Int
    let stock_status: String
    let manufacturer: String?
    let image: String?
    let attributes: [AttributesProduct]?
    let discounts: [DiscountsProduct]?
}

struct AttributesProduct: Codable, Identifiable {
    let id = UUID()
    let name: String
    let text: String
}

struct DiscountsProduct: Codable, Identifiable {
    let id = UUID()
    let quantity: Int
    let price: Int
}

struct AddProductStruct: Codable {
    let customer_id: String
    let hash: String
    let product_id: Int
    let quantity: Int
}

struct ResponseAddProduct: Codable {
    let status: Bool
    let error: String?
}

class ProductModel: ObservableObject {
    
    let product_id: Int
    
    init(product_id: Int){
        self.product_id = product_id
    }
    
    func getProduct(product_id: Int, completion: @escaping (ProductItem) -> ()){
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/getProduct&prod_id=\(product_id)") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//                let outputStr  = String(data: data, encoding: String.Encoding.utf8) ?? "" as String
//                print(outputStr)
                let products = try JSONDecoder().decode(ProductItem.self, from: data)
                
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    func addProduct(body: AddProductStruct, completion: @escaping (ResponseAddProduct) -> ()) {
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/addToCart") else {return}
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }

        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            do {
                let result = try JSONDecoder().decode(ResponseAddProduct.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }
        .resume()
        
    }
    
}
