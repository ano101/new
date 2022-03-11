//
//  LoaderView.swift
//  new
//
//  Created by Иван Котляр on 09.03.2022.
//

import SwiftUI

struct LoaderView: View {

    @State var animate = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 50) {
                Image("backload")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
                
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [Color("primary"), .purple]),center: .center), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 35, height: 35)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
                
            }
            .padding()
        }
        .background(Color.red)
        .onAppear {
            self.animate.toggle()
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
