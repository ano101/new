//
//  NetworkManager.swift
//  new
//
//  Created by Иван Котляр on 12.03.2022.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var showSheetError: Bool = false
    @Published var errorMessage = ""
    private let urlBase = "https://vinnayagramota.ru/index.php?route="
    func getItem<T: Codable> (for url: String, completion: @escaping (T) -> ()){
        guard let url = URL(string: "\(urlBase)\(url)") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.showSheetError = true
                self.errorMessage = "Ошибка url запроса"
                return
            }
            do {
                let task = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(task)
                }
            } catch {
                DispatchQueue.main.async {
                    self.showSheetError = true
                    self.errorMessage = "Ошибка формата JSON"
                }
                print(error)
            }
        }
        .resume()
    }
    
    func postItem<T: Codable, B: Codable> (for url: String, body: B, completion: @escaping (T) -> ()){
        guard let url = URL(string: "\(urlBase)\(url)") else {return}
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let task = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(task)
                }
            } catch {
                DispatchQueue.main.async {
                    self.showSheetError = true
                    self.errorMessage = "Ошибка формата JSON"
                }
                print(error)
            }
        }
        .resume()
    }
}
