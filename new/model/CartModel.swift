//
//  CartModel.swift
//  new
//
//  Created by Иван Котляр on 23.02.2022.
//

import SwiftUI

struct CartItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var price: Int
    var quantity: Int
    var product_id: Int
    var offset: CGFloat
    var isSwiped: Bool
}

