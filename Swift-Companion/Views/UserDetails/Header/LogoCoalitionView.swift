//
//  LogoCoalitionView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct LogoCoalitionView: View {

	var imageUrl: String
	var isPortraitMode: Bool

	var body: some View {
		VStack(alignment: .center) {
			if let url = URL(string: imageUrl) {
				SVGImage(url: url)
			}
		}
		.frame(width: 100)
		.padding(.leading, isPortraitMode ? 75 : 0)
	}
}
