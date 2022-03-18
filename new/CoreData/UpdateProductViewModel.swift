//
//  UpdateProductViewModel.swift
//  new
//
//  Created by Иван Котляр on 26.02.2022.
//

//import Foundation
//import CoreData
//
//enum ProductError: Error {
//    case productNotFound
//}
//
//class UpdateProductViewModel: ObservableObject {
//    
//    var name: String = ""
//    var image: String = ""
//    var price: Int = 0
//    var product_id: Int = 0
//    @Published var quantity: Int? = 0
//    
//    
//    func update(_ vs: ProductViewState) throws {
//        
//        guard let id = vs.id else {
//            throw ProductError.productNotFound
//        }
//        
//        let manager = CoreDataManager.shared
//        guard let product = CoreDataManager.shared.getProductById(id: id) else {
//            throw ProductError.productNotFound
//        }
//        
//        product.name = vs.name
//        product.image = vs.image
//        product.price = NSNumber(value: vs.price)
//        product.product_id = NSNumber(value: vs.product_id)
//        product.quantity = NSNumber(value: vs.quantity)
//        
//        manager.save()
//    }
//    
//    func getProductById(id: NSManagedObjectID) throws -> CartViewModel {
//        guard let product = CoreDataManager.shared.getProductById(id: id) else {
//            throw ProductError.productNotFound
//        }
//        
//        let productVM = CartViewModel(product: product)
//        return productVM
//    }
//    
//}
