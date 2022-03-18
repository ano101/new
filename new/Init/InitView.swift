//
//  InitView.swift
//  new
//
//  Created by Иван Котляр on 07.03.2022.
//

import SwiftUI

struct InitView: View {
    @ObservedObject var initViewModel: InitViewModel
    @ObservedObject var netManager: NetworkManager
    @Binding var isShow: Bool
    var body: some View {
        
        ZStack {
            if initViewModel.preload == true {
                LoaderView()
            } else {
                if initViewModel.statusLogin == true{
                    homeView(netManager: netManager)
                        .transition(.opacity)
                } else {
                    LoginView(initViewModel: initViewModel)
                }
                if netManager.showLoaderApi {
                    LoaderApiView()
                }
            }
            SheetErrorView(isShow: $netManager.showSheetError, errorMessage: $netManager.errorMessage)
        }
        .onAppear{
            initViewModel.preload = true
            initViewModel.IsLogin()
        }
        .animation(.easeOut(duration: 1), value: initViewModel.statusLogin)
    }
}

//very good! But why you don't create a new file Font? Why you init it here?
public extension Font {
    static let wineBigTitle = Font.custom("Montserrat", size: 20)
    static let wineTitle = Font.custom("Montserrat", size: 18)
    static let wineProductPrice = Font.custom("Montserrat", size: 17)
    static let wineSubTitle = Font.custom("Montserrat", size: 16)
    static let wineDefault = Font.custom("Montserrat", size: 14)
    static let wineProductDiscount = Font.custom("Montserrat", size: 13)
    static let wineNameAlt = Font.custom("Montserrat", size: 12)
    static let wineSpecialLabel = Font.custom("Montserrat", size: 10)
}
