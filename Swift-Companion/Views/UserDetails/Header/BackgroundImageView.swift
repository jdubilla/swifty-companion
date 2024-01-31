//
//  BackgroundImageView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct BackgroundImageView: View {

	var background: Image?
	var geometry: GeometryProxy

	var body: some View {
			if background != nil {
				background!
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: shouldAdjustHeight(in: geometry) ? 100 : 200)
					.clipped()
			} else {
				Image("background42")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(height: shouldAdjustHeight(in: geometry) ? 100 : 200)
					.clipped()
			}
	}

	private func shouldAdjustHeight(in geometry: GeometryProxy) -> Bool {
		return geometry.size.width > geometry.size.height
	}
}
