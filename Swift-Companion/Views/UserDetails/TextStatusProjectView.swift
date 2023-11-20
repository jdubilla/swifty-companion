//
//  TextStatusProjectView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct TextStatusProjectView: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 15))
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(4)
            .background(color)
            .clipShape(RoundedCorner(radius: 5))
    }
}

//#Preview {
//    TextStatusProjectView()
//}
