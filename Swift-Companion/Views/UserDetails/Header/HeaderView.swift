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
				LogoCoalitionView(imageUrl: request?.coalitions?.last?.imageUrl ?? "", isPortraitMode: shouldAdjustHeight(in: geometry))
				Spacer()
				OtherInfosUserView(request: $request, mainColor: $mainColor, geometry: geometry)
				Spacer()
				CloseButtonView(isUserSearch: $isUserSearch)
			}.frame(maxWidth: .infinity, maxHeight: shouldAdjustHeight(in: geometry) ? 100 : 200)
				.foregroundStyle(.black)
		}
		.onChange(of: geometry.size) {
			bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
		}
		.onAppear() {
			bgImageDownloader.getImage(path: request?.coalitions?.last?.coverUrl ?? "")
		}
	}

	private func shouldAdjustHeight(in geometry: GeometryProxy) -> Bool {
		return geometry.size.width > geometry.size.height
	}
}
