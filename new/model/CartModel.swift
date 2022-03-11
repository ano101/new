//
//  CartModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import SwiftUI

//struct CartItem: Identifiable {
//    var id = UUID().uuidString
//    var name: String
//    var image: String
//    var price: Int
//    var quantity: Int
//    var product_id: Int
//    var offset: CGFloat
//    var isSwiped: Bool
//}

struct CartItem: Codable, Identifiable {
    let id = UUID()
    let status: Bool
    let products: [ProductResponse]?
    let error: String?
    let total: Double
}

struct ProductResponse: Codable, Identifiable {
    let id = UUID()
    let cart_id: Int
    let thumb: String
    let name: String
    let model: String
    let quantity: Int
    let price: Double
    let total: Double
}

struct CartRemove: Codable {
    let cart_id: Int
    let hash: String
    let customer_id: String
}

class CartModel {
    func getProducts(body: [String: String], completion: @escaping (CartItem) -> ()) {
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/getCart") else {return}
        
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
                let result = try JSONDecoder().decode(CartItem.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }
        .resume()
        
    }
    func delProd(body: CartRemove, completion: @escaping (DefaultResponse) -> ()){
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/delCartProduct") else {return}
        
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
                let result = try JSONDecoder().decode(DefaultResponse.self, from: data)
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
