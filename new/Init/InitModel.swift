//
//  InitModel.swift
//  new
//
//  Created by Иван Котляр on 09.03.2022.
//

import Foundation

struct CheckHash: Codable {
    let status: Bool
    let error: String?
}

struct SendCheckHash: Codable {
    let hash: String
    let customer_id: String
}

struct SendUserLogin: Codable {
    let email: String
    let password: String
}

struct UserLogin: Codable, Identifiable {
    let id = UUID()
    let status: Bool
    let error: String?
    let hash: String?
    let user_id: String?
}
