//
//  LoaderView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 16/11/2023.
//

import SwiftUI

struct LoaderView: View {
    
    @State var animate = true
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                
                ZStack {
                    Image("background42")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea(.all)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    Circle()
                        .trim(from: 0, to: 0.8).stroke(AngularGradient(gradient: .init(colors: [.blue, .purple]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 45, height: 45)
                        .rotationEffect(.init(degrees: self.animate ? 360 : 0))
//                        .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                }
            }.onAppear() {
                self.animate.toggle()
            }
        }
    }
}

//#Preview {
//    LoaderView()
//}
