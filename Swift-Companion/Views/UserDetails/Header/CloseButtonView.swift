//
//  CloseButtonView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct CloseButtonView: View {
    
    @Binding var isUserSearch: Bool
    
    let colorCrossButton = Color(red: Double(0xFF) / 255.0, green: Double(0x4C) / 255.0, blue: Double(0x4C) / 255.0)
    
    var body: some View {
        VStack {
            Spacer().frame(height: 60)
            Button {
                withAnimation {
                    isUserSearch = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundStyle(colorCrossButton)
            }
            Spacer()
        }
		.frame(width: 40, height: 200)
		.padding(.trailing, 10)
    }
}
