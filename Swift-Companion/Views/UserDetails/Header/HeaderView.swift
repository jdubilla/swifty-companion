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
	var geometry: GeometryProxy
	
	@ObservedObject var bgImageDownloader: ImageDownloader = ImageDownloader()

	var body: some View {
		ZStack {
			BackgroundImageView(background: bgImageDownloader.image, geometry: geometry)
			HStack {
				LogoCoalitionView(imageUrl: request?.coalitions?.last?.imageUrl ?? "")
				Rectangle()
					.frame(width: shouldAdjustHeight(in: geometry) ? 180 : 0)
					.opacity(0)
				OtherInfosUserView(request: $request, mainColor: $mainColor, geometry: geometry)
				Rectangle()
					.frame(width: shouldAdjustHeight(in: geometry) ? 200 : 0)
					.opacity(0)
				CloseButtonView(isUserSearch: $isUserSearch)
			}.frame(maxWidth: .infinity, maxHeight: shouldAdjustHeight(in: geometry) ? 100 : 200)
		}
		.onChange(of: geometry.size) {
			print("Image link changed")
			bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
		}
		.onAppear() {
			bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
		}
		.ignoresSafeArea(.all)
	}

	private func shouldAdjustHeight(in geometry: GeometryProxy) -> Bool {
		return geometry.size.width > geometry.size.height
	}
}
