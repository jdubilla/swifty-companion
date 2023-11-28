//
//  LogoCoalitionView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct LogoCoalitionView: View {
    
    var imageUrl: String?
    
    var body: some View {
        VStack(alignment: .center) {
            SVGImage(url: URL(string: imageUrl ?? "")!)
        }.frame(width: 100)
    }
}

//#Preview {
//    LogoCoalitionView()
//}
