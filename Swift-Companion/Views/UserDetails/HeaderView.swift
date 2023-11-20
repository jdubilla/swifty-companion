//
//  HeaderView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 18/11/2023.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest
    @Binding var mainColor: Color?
    
    let bgImageDownloader: ImageDownloader = ImageDownloader()
    
    let colorCrossButton = Color(red: Double(0xFF) / 255.0, green: Double(0x4C) / 255.0, blue: Double(0x4C) / 255.0)
    
    var body: some View {
        ZStack {
            if bgImageDownloader.image != nil {
                bgImageDownloader.image!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            }
            HStack {
                VStack(alignment: .center) {
                    SVGImage(url: URL(string: request.coalitions?[1].imageUrl ?? "")!)
                }
                .frame(width: 100)
                VStack(alignment: .leading) {
                    Spacer().frame(height: 25)
                    if let user = request.user {
                        HeaderUserInfoView(image: "person.fill", text: user.login, color: $mainColor)
                        HeaderUserInfoView(image: "envelope.circle", text: user.email, color: $mainColor)
                        HeaderUserInfoView(image: "dollarsign.circle.fill", text: "\(String(user.wallet)) ₳", color: $mainColor)
                        HeaderUserInfoView(image: "pc", text: String(user.location ?? " Unavailable"), color: $mainColor)
                    }
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Spacer().frame(height: 60)
                    Button {
                        isUserSearch = false
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
            }.frame(maxWidth: .infinity)
        }.onAppear() {
            bgImageDownloader.getImage(path: request.coalitions?[1].coverUrl ?? "")
            print(request.user?.cursus_users[1].skills ?? "")
        }
    }
}

//#Preview {
//    HeaderView()
//}


