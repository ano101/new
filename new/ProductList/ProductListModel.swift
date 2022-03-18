//
//  ProductListModel.swift
//  new
//
//  Created by Иван Котляр on 21.02.2022.
//

import Foundation
struct ProductList: Identifiable, Codable {
    let id = UUID()
    let status: Bool
    let product: [Product]?
    let error: String?
}
struct Product: Identifiable, Codable {
    let id = UUID()
    var product_id: Int
    var name: String
    var image: String?
    var quantity: Int
    var stock_status: String
    var price: Int
    var special: Int?
    var price2: Int?
    var discounts: [Discounts]?
    var attributes: [String]?
}

struct Discounts: Codable {
    var quantity: Int
    var price: Int
}

struct Attributes: Codable, Identifiable {
    let id = UUID()
    let value: String
}
