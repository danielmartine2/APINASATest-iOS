//
//  SearchBarView.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 21/04/21.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing:0) {
            
            TextField("Buscar ...", text: $text)
                .font(.custom("Nunito-Regular", size: 16))
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                }) {
                    Text("Cancel")
                        .font(.custom("Nunito-Regular", size: 16))
                }
                .padding(.horizontal, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
