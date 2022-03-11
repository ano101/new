//
//  ProductListModel.swift
//  new
//
//  Created by Иван Котляр on 21.02.2022.
//

import Foundation


class ProductsFeed: ObservableObject {
    
    typealias Element = Product

    @Published var Products = [Product]()
    var startIndex: Int { Products.startIndex }
    var endIndex: Int { Products.endIndex }
    var newPageToLoad = 1
    var currentlyLoading = false
    let catid: Int
    var urlBase: String
    var doneLoading = false
    
    init(catid: Int){
        self.catid = catid
        urlBase = "https://vinnayagramota.ru/index.php?route=api/mob/getListProducts&cate_id=\(catid)&page="
        //loadMoreProducts()
        
    }
    
    subscript(position: Int) -> Product {
        return Products[position]
    }

    
    func loadMoreProducts(currentItem: Product? = nil,shouldLoadMore: Bool, completion: @escaping ([Product]) -> () ) {
        if currentlyLoading == true {
            return
        }
        if doneLoading == true {
            return
        }
        if !shouldLoadMore  {
            return
        }
        currentlyLoading = true
        print("Загружаю товар")
        let urlString = "\(urlBase)\(newPageToLoad)"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
//                let outputStr  = String(data: data, encoding: String.Encoding.utf8) ?? "" as String
//                print(outputStr)
                let products = try JSONDecoder().decode([Product].self, from: data)
                
                DispatchQueue.main.async {
                    completion(products)
                    self.newPageToLoad += 1
                    self.currentlyLoading = false
                    self.doneLoading = (products.count == 0)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    

  
}

class Product: Identifiable, Codable {
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
    
    init(product_id: Int, name: String, image: String, quantity: Int, stock_status: String, price: Int, special: Int?, price2: Int?,
         discounts: [Discounts]?,
         attributes: [String]?
    ){
        self.product_id = product_id
        self.name = name
        self.image = image
        self.quantity = quantity
        self.stock_status = stock_status
        self.price = price
        self.special = special
        self.price2 = price2
        self.discounts = discounts
        self.attributes = attributes
    }
}

struct Discounts: Codable {
    var quantity: Int
    var price: Int
}


class Attributes: Codable, Identifiable {
    let uuid = UUID()
    var value: String

    init(value: String){
        self.value = value
    }
}
