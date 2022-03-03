//
//  CardPoup.swift
//  new
//
//  Created by Иван Котляр on 02.03.2022.
//

import SwiftUI

struct CardPoup: View {
    @Environment(\.presentationMode) var presentationMode
//    @Binding var showCardPoup: Bool
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.purple
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}

