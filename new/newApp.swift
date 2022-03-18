//
//  newApp.swift
//  new
//
//  Created by Иван Котляр on 17.02.2022.
//

import SwiftUI
import CoreData


@main
struct newApp: App {
    @StateObject var netManager:NetworkManager
    @StateObject var initViewModel:InitViewModel
    
    init(){
        let netManager = NetworkManager()
        _netManager = StateObject(wrappedValue: netManager)
        _initViewModel = StateObject(wrappedValue: InitViewModel(netManager: netManager))
    }
    
    var body: some Scene {
        WindowGroup {
            InitView(initViewModel: initViewModel, netManager: netManager, isShow: $netManager.showSheetError)
        }
    }
    
}
