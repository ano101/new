//
//  ImageView.swift
//  new
//
//  Created by Иван Котляр on 01.03.2022.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageModel: ImageModel
    
    init(urlString: String?){
        imageModel = ImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: imageModel.image ?? ImageView.defaultImage!)
            .resizable()
            .scaledToFit()
    }
    static var defaultImage = UIImage(systemName: "video")
}

