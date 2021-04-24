//
//  WithoutInternet.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 24/04/21.
//

import SwiftUI

struct WithoutInternet: View {
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                Text("No tienes Internet. Comprueba la onexión.")
                    .font(.custom("Nunito-Regular", size: 16))
                    .foregroundColor(Color(.systemGray))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: self.action, label: {
                    Text("REINTENTAR")
                        .foregroundColor(.blue)
                })
                Spacer()
            }
        }    }
}

struct WithoutInternet_Previews: PreviewProvider {
    static var previews: some View {
        WithoutInternet(action: {})
    }
}
