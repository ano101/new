//
//  InitViewModel.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import Foundation

class InitViewModel: ObservableObject {
    @Published var statusLogin: Bool = false
    @Published var preload: Bool = false
    let netManager: NetworkManager
    
    init(netManager:NetworkManager){
        self.netManager = netManager
    }

    public func IsLogin() {
        if UserDefaults.standard.bool(forKey: "isLogin") == false {
            setDefault()
        } else {
            if let hash = UserDefaults.standard.string(forKey: "hash") , let customer_id = UserDefaults.standard.string(forKey: "user_id"){
                let body = SendCheckHash(hash: hash, customer_id: customer_id)
                netManager.postItem(for: "api/mob/checkhash", body: body) { (check: CheckHash) in
                    sleep(2)
                    if check.status == true {
                        self.statusLogin = true
                        self.preload = false
                    } else {
                        self.setDefault()
                        if let error = check.error {
                            self.netManager.showSheetError = true
                            self.netManager.errorMessage = error
                        }
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
        let body = SendUserLogin(email: login, password: password)
        netManager.postItem(for: "api/mob/auth", body: body) { (user: UserLogin) in
            print(user)
            if user.status == true {
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(user.user_id, forKey: "user_id")
                UserDefaults.standard.set(user.hash, forKey: "hash")
                self.statusLogin = true
            } else {
                self.statusLogin = false
                if let error = user.error {
                    self.netManager.showSheetError = true
                    self.netManager.errorMessage = error
                }
            }
        }
    }
    
}
