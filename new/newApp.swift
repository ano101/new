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
    let initViewModel = InitViewModel()
        var body: some Scene {
            WindowGroup {
                InitView()
                    .environmentObject(initViewModel)
            }
        }

}
