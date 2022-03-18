//
//  LoginView.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var initViewModel: InitViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Image("backload")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 8, content:  {
                Text("Эл. почта")
                    .font(.wineSubTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                TextField("Эл. почта", text: $email)
                    .font(.wineBigTitle)
                    .foregroundColor(Color("primary"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8, content:  {
                Text("Пароль")
                    .font(.wineSubTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                SecureField("123456", text: $password)
                    .font(.wineBigTitle)
                    .foregroundColor(Color("primary"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,20)
            Button(action: {
                initViewModel.sendAuth(login: email, password: password)
            }){
                Text("Войти")
                    .font(.wineTitle)
                    .fontWeight(.semibold)
                    .padding(.all, 7.0)
                    .frame(maxWidth: .infinity)
                    .background(Color("primary"))
                    .foregroundColor(Color(red: 138.0, green: 109.0, blue: 59.0))
            }
            
            Button(action: {}){
                Text("Забыли пароль?")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .background(.white)
        }
        .padding()
    }
}
