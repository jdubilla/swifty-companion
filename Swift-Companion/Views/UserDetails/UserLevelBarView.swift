//
//  UserLevelBarView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 18/11/2023.
//

import SwiftUI

struct UserLevelBarView: View {
    
    @Binding var color: Color
    @Binding var request: APIRequest?
    
    let maxLevel: Double = 100
    
    let userImageDownloader: ImageDownloader = ImageDownloader()
    let leftPadding: CGFloat = 80
    
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: leftPadding)
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    Rectangle()
                        .frame(width: geometry.size.width, height: 20)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    Rectangle()
                        .frame(width: min(CGFloat((getDecimalPart() / self.maxLevel) * (geometry.size.width)), geometry.size.width), height: 20)
                        .foregroundColor(color)
                    
                    Text(String(request?.user?.cursus_users.last?.level ?? 0.0))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .offset(x: 20)
                    if let image = userImageDownloader.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(radius: 10, x: 10, y: 10)
                            .offset(x: -70, y: -40)
                    }
                }
            }
        }
        .frame(height: 50)
        .onAppear() {
            userImageDownloader.getImage(path: request?.user?.image.link ?? "")
        }
    }
    
    func getDecimalPart() -> Double {
        let number: Double = request?.user?.cursus_users.last?.level ?? 0.0
        let decimalPart = Double((number.truncatingRemainder(dividingBy: 1)) * 100)
        return decimalPart
    }
}
