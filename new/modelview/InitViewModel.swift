//
//  InitViewModel.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import Foundation

class InitViewModel: ObservableObject {
    @Published var statusLogin: Bool = false
    @Published var errorLogin: Bool = false
    @Published var preload: Bool = false
    private let model = InitModel()

    
    public func IsLogin() {
            print("sleep for 2 seconds.")
             // working
        
        if UserDefaults.standard.bool(forKey: "isLogin") == false {
            setDefault()
        } else {
            if let hash = UserDefaults.standard.string(forKey: "hash") , let user_id = UserDefaults.standard.string(forKey: "user_id"){
                let body: [String : String] = ["hash": hash, "user_id": user_id]
                model.getHash(body: body) { (check) in
                    sleep(2)
                    if check.status == true {
                        
                        self.statusLogin = true
                        self.preload = false
                    } else {
                        self.setDefault()
                    }
                }
            } else {
                setDefault()
            }
        }
    }
    
    public func setDefault(){
        self.preload = false
        self.statusLogin = false
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "hash")
    }
    
    public func sendAuth(login: String,password: String){
        let body: [String : String] = ["email": login, "password": password]
        model.sendAuth(body: body) { (user) in
            if user.status == true {
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(user.user_id, forKey: "user_id")
                UserDefaults.standard.set(user.hash, forKey: "hash")
                self.statusLogin = true
                self.errorLogin = false
            } else {
                self.statusLogin = false
                self.errorLogin = true
            }
        }
    }
    
}
