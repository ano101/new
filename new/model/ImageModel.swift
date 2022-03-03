//
//  ImageModel.swift
//  new
//
//  Created by Иван Котляр on 01.03.2022.
//

import Foundation
import SwiftUI

class ImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String?){
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage(){
        if loadImageFromCache() {
            print("Cache Hit")
            return
        }
        print("Cache Miss")
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl(){
        guard let urlString = urlString else {
            return
        }

        let url = URL(string: "https://vinnayagramota.ru/image/\(urlString)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler:
                                                getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else {
            print("Ошибка: \(error!)")
            return
        }
        guard let data = data else {
            print("Не найдена data")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    
    func get(forKey: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        imageCache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
