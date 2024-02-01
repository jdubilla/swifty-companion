//
//  HeaderUserInfoView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 18/11/2023.
//

import SwiftUI

struct HeaderUserInfoView: View {
    
    var image: String
    var text: String
    @Binding var color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Spacer().frame(width: 0)
            Image(systemName: image)
                .resizable()
                .frame(width: 15, height: 15)
                .padding(2)
                .foregroundStyle(.white)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 23)
        .background(.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
