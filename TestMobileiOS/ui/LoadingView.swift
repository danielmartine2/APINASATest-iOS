//
//  LoadingView.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 24/04/21.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Text("Cargando...")
                    .font(.custom("Nunito-Regular", size: 16))
                    .offset(x: 0, y: -25)
                Spacer()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
