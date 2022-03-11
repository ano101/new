//
//  LoginView.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var initViewModel: InitViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            Image("backload")
                .resizable()
                .scaledToFit()
            //.frame(height: 55, alignment: .center)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Эл. почта")
                    .font(.projectSubTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                TextField("Эл. почта", text: $email)
                    .font(.custom("Montserrat", size: 20))
                    .foregroundColor(Color("primary"))
                    .padding(.top,5)
                
                Divider()
            }
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8)  {
                Text("Пароль")
                    .font(.projectSubTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                SecureField("123456", text: $password)
                    .font(.custom("Montserrat", size: 20))
                    .foregroundColor(Color("primary"))
                    .padding(.top,5)
                
                Divider()
            }
            .padding(.top,20)
            
            Button(action: { initViewModel.sendAuth(login: email, password: password) }){
                Text("Войти")
                    .font(.projectTitle)
                    .fontWeight(.semibold)
                    .padding(.all, 7.0)
                    .frame(maxWidth: .infinity)
                    .background(Color("primary"))
                    .foregroundColor(Color(red: 138.0, green: 109.0, blue: 59.0))
                    
            }
            if initViewModel.errorLogin == true {
                Text("Ошибка email или пароль!")
                    .font(.projectTitle)
                    .fontWeight(.semibold)
                    .padding(.all, 7.0)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.979, green: 0.922, blue: 0.8))
                    .foregroundColor(Color("#8a6d3b"))
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
//TODO: Переделать все FONT. Ты их повторяешь думаю кучу раз)). Вынести в отдельный файл

public extension Font {
    
    static let projectTitle = Font.custom("Montserrat", size: 18)
    static let projectSubTitle = Font.custom("Montserrat", size: 16)
}

