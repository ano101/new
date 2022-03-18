//
//  CartModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import SwiftUI

struct CartItem: Codable, Identifiable {
    let id = UUID()
    let status: Bool
    let products: [ProductResponse]?
    let error: String?
    let total: Double
}

struct ProductResponse: Codable, Identifiable {
    let id = UUID()
    let cartId: Int
    let thumb: String
    let name: String
    let name_alt: String
    let model: String
    let quantity: Int
    let price: Double
    let total: Double
}

struct CartRemove: Codable {
    let cartId: Int
    let hash: String
    let customer_id: String
}

struct SendGetCart: Codable {
    let hash: String
    let customer_id: String
}

struct DefaultResponse: Codable {
    let status: Bool
    let error: String?
}

struct SendQuantityProductCart: Codable {
    let cartId: Int
    let quantity: Int
    let hash: String
    let customer_id: String
}
