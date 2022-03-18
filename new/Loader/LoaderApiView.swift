//
//  LoaderApiView.swift
//  new
//
//  Created by Иван Котляр on 18.03.2022.
//

import SwiftUI

struct LoaderApiView: View {
    @State var animate = false
    var body: some View {
        ZStack {
            Color.black.opacity(0.45).ignoresSafeArea()
            VStack(spacing: 50) {
                Circle()
                    .trim(from: 0, to: 0.95)
                    .stroke(AngularGradient(gradient: .init(colors: [.black, .white]),center: .center), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .frame(width: 50, height: 50)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(.linear(duration: 0.7).repeatForever(autoreverses: false), value: animate)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        }
        .onAppear {
            self.animate.toggle()
        }
    }
}

struct LoaderApiView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderApiView()
    }
}
