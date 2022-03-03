//
//  LogoView.swift
//  new
//
//  Created by Иван Котляр on 22.02.2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image("newtop")
                .resizable()
                .scaledToFit()
                .frame(width: 200, alignment: .center)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
