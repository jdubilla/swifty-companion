//
//  SectionUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 19/11/2023.
//

import SwiftUI

struct SectionUserView: View {
    
    var text: String
    @Binding var color: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(text)
                .padding(7)
                .foregroundStyle(.white)
                .background(color)
                .fontWeight(.bold)
                .font(.system(size: 15))
                .roundedCorner(5, corners: [.bottomRight])
                .shadow(radius: 10, x: 0, y : 10)
            VStack(alignment: .trailing, spacing: 0) {
                Rectangle()
                    .frame(height: 12)
                    .foregroundStyle(color)
                    .shadow(radius: 10, x: 0, y : 10)
            }
        }
    }
}
