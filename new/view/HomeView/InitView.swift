//
//  InitView.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import SwiftUI

struct InitView: View {
    @EnvironmentObject var initViewModel: InitViewModel
    var body: some View {
        ZStack {
            if initViewModel.preload == true {
                LoaderView()
            } else {
                if initViewModel.statusLogin == true{
                    homeView()
                        .transition(.opacity)
                } else {
                    LoginView()
                }
            }
        }
        .onAppear{
            initViewModel.preload = true
            initViewModel.IsLogin()
        }
        .animation(.easeOut(duration: 1), value: initViewModel.statusLogin)
    }
}

