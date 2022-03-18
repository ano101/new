//
//  SheetErrorView.swift
//  new
//
//  Created by Иван Котляр on 15.03.2022.
//

import SwiftUI

struct SheetErrorView: View {
    @Binding var isShow: Bool
    @Binding var errorMessage: String
    @State private var curHeight: CGFloat = 150
    @State private var isDragging = false
    let minHeight: CGFloat = 100
    let maxHeight: CGFloat = 300
    var body: some View {
        ZStack(alignment:.bottom){
            if isShow {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShow = false
                    }
                message
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShow)
    }
    
    var message: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .foregroundColor(Color("primary"))
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            ZStack {
                VStack {
                    Text("\(errorMessage)")
                        .font(.wineSubTitle)
                        .fontWeight(.medium)
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom,35)
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(.white)
        )
        .animation(.easeIn(duration: 0.45), value: isDragging)
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount / 6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight {
                    curHeight = maxHeight
                } else if curHeight < minHeight {
                    isShow = false
                    curHeight = 150
                }
            }
    }
}


//struct SheetErrorView_Previews: PreviewProvider {
//    @Binding var isShow:Bool
//    @Binding var errorMessage:String
//    init(){
//        self.isShow = true
//        self.errorMessage = "ошибка"
//    }
//     static var previews: some View{
//         SheetErrorView(isShow: $isShow,errorMessage: $errorMessage)
//    }
//}
