//
//  CatalogModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

struct CategoriesList: Codable, Identifiable {
    let id = UUID()
    let categories: [Category]
    let status: Bool
    let error: String?
}

struct Category: Codable, Identifiable {
    let id = UUID()
    let category_id: Int
    let name: String
}
