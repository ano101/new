//
//  test.swift
//  new
//
//  Created by Иван Котляр on 03.03.2022.
//

import SwiftUI

struct test: View {
    var body: some View {
        VStack {
            HStack {
                Text("Итого")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                Spacer()
                
                Text("5000")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            Button(action:{}){
                Text("Оформить заказ")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10.0)
                    .frame(width: UIScreen.main.bounds.width - 15)
                    .background(
                        LinearGradient(gradient: .init(colors:[Color.purple, Color("primary")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
            }
            .padding(.bottom)
        }
        .background(Color.white)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
