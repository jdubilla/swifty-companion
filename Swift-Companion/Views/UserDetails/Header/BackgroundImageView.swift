//
//  BackgroundImageView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct BackgroundImageView: View {
    
    var background: Image?

//    let bgImageDownloader: ImageDownloader = ImageDownloader()

//	if (background != null) {
//		print("NOT NULL")
//	} else {
//		print("NULL !!!")
//	}

    var body: some View {
        if background != nil {
            background!
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
		} else {
			Image("background42")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(height: 200)
				.clipped()

		}
    }
//        .onAppear() {
//        bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
//    }
}

//#Preview {
//    BackgroundImageView()
//}
