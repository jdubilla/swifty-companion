//
//  AchievementsView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 28/11/2023.
//

import SwiftUI

struct AchievementsView: View {

	@Binding var color: Color
	@Binding var request: APIRequest?

	var body: some View {
		SectionUserView(text: "Achievements", color: $color)

		VStack(alignment: .leading) {
			ScrollView(.vertical) {
				if let achievements = request?.user?.achievements {
					if (!achievements.isEmpty) {
						ForEach(achievements) { achievement in
							HStack {
								SVGImage(url: URL(string: achievement.image)!)
								Spacer()
								VStack(alignment: .center) {
									Text(achievement.name)
										.font(.system(size: 18))
										.fontWeight(.bold)
										.multilineTextAlignment(.center)
									Text(achievement.description)
										.foregroundStyle(.gray)
										.font(.callout)
										.multilineTextAlignment(.center)
								}
								Spacer()
							}
							.padding(10)
							.background(color.opacity(0.3))
							.cornerRadius(10)
						}
					} else {
						Text("Aucun achievement à afficher")
					}
				}
			}
		}.padding(.horizontal)
			.frame(maxHeight: 300)
	}
}
