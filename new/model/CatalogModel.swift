//
//  CatalogModel.swift
//  new
//
//  Created by Иван Котляр on 18.02.2022.
//

import Foundation

struct Category: Codable, Identifiable {
    let id = UUID()
    let category_id: Int
    let name: String
}

class CatalogModel: ObservableObject {

    func getCatalog(completion: @escaping ([Category]) -> ()){
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/getCategorys") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
