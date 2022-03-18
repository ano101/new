//
//  homeView.swift
//  new
//
//  Created by Иван Котляр on 17.02.2022.
//

import SwiftUI

struct homeView: View {
    @ObservedObject var netManager: NetworkManager
    var body: some View {
        VStack(spacing: 0){
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
                            .font(.wineDefault)
                    }
                
                CatalogView(netManager: netManager)
                    .tabItem {
                        Image(systemName: "list.bullet.below.rectangle")
                        Text("Каталог")
                            .font(.wineDefault)
                    }
                
                CartView(netManager: netManager)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Корзина")
                            .font(.wineDefault)
                    }
                
                Text("Избранное")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Избранное")
                            .font(.wineDefault)
                    }
                
                Text("Профиль")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Профиль")
                            .font(.wineDefault)
                    }
            }
            .accentColor(Color("primary"))
            .onAppear(){
                UITabBar.appearance().backgroundColor = .white
            }
        }
    }
}

//struct homeView_Previews: PreviewProvider {
//    static var previews: some View {
//        homeView()
//    }
//}
