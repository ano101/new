//
//  InitModel.swift
//  new
//
//  Created by Иван Котляр on 09.03.2022.
//

import Foundation

class InitModel {
    
    func sendAuth(body: [String : String], completion: @escaping (UserLogn) -> ()) {
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/auth") else {return}
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            do {
                let result = try JSONDecoder().decode(UserLogn.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }
        .resume()
        
    }
    
    func getHash(body: [String:String], completion: @escaping (CheckHash) -> ()){
        guard let url = URL(string: "https://vinnayagramota.ru/index.php?route=api/mob/checkhash") else {return}
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            do {
                let result = try JSONDecoder().decode(CheckHash.self, from: data)
                    DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
}

struct CheckHash: Codable {
    let status: Bool
}


struct UserLogn: Codable, Identifiable {
    let id = UUID()
    let status: Bool
    let hash: String?
    let user_id: String?
}
