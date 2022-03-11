//
//  homeView.swift
//  new
//
//  Created by Иван Котляр on 17.02.2022.
//

import SwiftUI

struct homeView: View {
    var body: some View {
      //  ZStack {
        VStack(spacing: 0){
            
//           
//            NavigationBarView()
//                .padding(.horizontal, 15)
//                .padding(.bottom)
//                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
//                .background(Color.white)
//                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            
            
            TabView {
                
                Text("Главная")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Обзор")
                            .font(.custom("Montserrat", size: 14))
                    }
                
                CatalogView()
                    .tabItem {
                        Image(systemName: "list.bullet.below.rectangle")
                        Text("Каталог")
                            .font(.custom("Montserrat", size: 14))
                    }
                
                CartView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Корзина")
                            .font(.custom("Montserrat", size: 14))
                    }
                
                Text("Избранное")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Избранное")
                            .font(.custom("Montserrat", size: 14))
                    }
                
                Text("Профиль")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
                            .font(.custom("Montserrat", size: 14))
                    }
                
            }
            .accentColor(Color("primary"))
            .onAppear(){
                UITabBar.appearance().backgroundColor = .white
            }
        }
        
   // }
        
    }
}


struct profileView: View {
    var body: some View {
        Text("Profile")
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
