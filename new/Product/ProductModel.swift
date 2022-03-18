//
//  ProductModel.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import Foundation

struct ProductItem: Codable, Identifiable {
    let id = UUID()
    let status: Bool
    let error: String?
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
    let alert: String?
    let error: String?
}
