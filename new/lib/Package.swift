//
//  Package.swift
//  new
//
//  Created by Иван Котляр on 03.03.2022.
//

import Foundation
import SystemPackage

let package = Package(
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0")
    ],
)
