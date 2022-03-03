//
//  ProductListModel.swift
//  new
//
//  Created by Иван Котляр on 21.02.2022.
//

import Foundation


class ProductsFeed: ObservableObject, RandomAccessCollection {
    
    typealias Element = Product
    
    @Published var Products = [Product]()
    var startIndex: Int { Products.startIndex }
    var endIndex: Int { Products.endIndex }
    var newPageToLoad = 1
    var currentlyLoading = false
    let catid: Int
    var urlBase: String
    
    
    init(catid: Int){
        self.catid = catid
        urlBase = "https://vinnayagramota.ru/index.php?route=api/mob/getListProducts&cate_id=\(catid)&page="
        loadMoreProducts()
        
    }
    
    subscript(position: Int) -> Product {
        return Products[position]
    }

    
    func loadMoreProducts(currentItem: Product? = nil ) {
        
        if !shouldLoadMoreData(currentItem: currentItem){
            return
        }
        currentlyLoading = true

        let urlString = "\(urlBase)\(newPageToLoad)"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: parseProductsFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: Product? = nil ) -> Bool{
        if currentlyLoading {
            return false
        }
        guard let currentItem = currentItem else {
            return true
        }
        guard let lastItem = Products.last else {
            return true
        }
        return currentItem.id == lastItem.id
    }
    
    func parseProductsFromResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else {
            print("Ошибка: \(error!)")
            currentlyLoading = false
            return
        }
        guard let data = data else {
            print("Товар не найден")
            currentlyLoading = false
            return
        }
        
        let newProducts = parseProductsFromData(data: data)
        
        DispatchQueue.main.async {
            self.Products.append(contentsOf: newProducts)
            self.newPageToLoad += 1
            self.currentlyLoading = false
        }
        
    
}
    
    func parseProductsFromData(data: Data) -> [Product]{
        print("Data = \(data)")
        do {
            let jsonObject = try JSONDecoder().decode([Product].self, from: data)
            
            let newProducts = jsonObject
            return newProducts
        } catch let error {
            print("Error \(error)")
            return []
        }
        
    }
  
}

class Product: Identifiable, Codable {
    let id = UUID()
    var product_id: Int
    var name: String
    var image: String
    var quantity: Int
    var stock_status: String
    var price: Int
    var special: Int?
    var price2: Int?
    //var discounts: [Discounts]?
    //var attributes: [Attributes]?
    
    init(product_id: Int, name: String, image: String, quantity: Int, stock_status: String, price: Int, special: Int?, price2: Int?
        // discounts: [Discounts]?,
        // attributes: [Attributes]?
    ){
        self.product_id = product_id
        self.name = name
        self.image = image
        self.quantity = quantity
        self.stock_status = stock_status
        self.price = price
        self.special = special
        self.price2 = price2
       // self.discounts = discounts
       // self.attributes = attributes
    }
}

struct Discounts: Decodable {
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
