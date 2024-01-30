//
//  HeaderView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 18/11/2023.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest?
    @Binding var mainColor: Color
    
    let bgImageDownloader: ImageDownloader = ImageDownloader()
    
    var body: some View {
        ZStack {
            BackgroundImageView(background: bgImageDownloader.image)
            HStack {
//				if let imageUrl = request?.coalitions?.last?.imageUrl {
//					LogoCoalitionView(imageUrl: imageUrl)
//				}
                LogoCoalitionView(imageUrl: request?.coalitions?.last?.imageUrl ?? "")
                OtherInfosUserView(request: $request, mainColor: $mainColor)
                CloseButtonView(isUserSearch: $isUserSearch)
            }.frame(maxWidth: .infinity)
        }
        .onAppear() {
            bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
        }
    }
}
