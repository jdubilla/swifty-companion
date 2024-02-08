//
//  SecondeView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import SwiftUI
import UIKit
import WebKit

struct UserDetails: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest?
    var geometry: GeometryProxy
    
    @State var mainColor: Color = .orange
    
    var body: some View {
//		GeometryReader { geometry in
			VStack(spacing: 0) {
				HeaderView(isUserSearch: $isUserSearch, request: $request, mainColor: $mainColor, geometry: geometry)
				UserLevelBarView(color: $mainColor, request: $request, geometry: geometry)
				ScrollView(.vertical) {
					ProjectsUserView(color: $mainColor, request: $request, geometry: geometry)
					SkillsUserView(color: $mainColor, request: $request)
					LocationsUserView(color: $mainColor, request: $request, isPortraitMode: shouldAdjustHeight(in: geometry))
					AchievementsView(color: $mainColor, request: $request)
				}
			}
            .ignoresSafeArea(shouldAdjustHeight(in: geometry) ? .container : .all)
			.onAppear() {
				if let color = request?.coalitions?.last?.color {
					mainColor = Color(hex: color)
				} else {
					mainColor = Color.orange
				}
			}
    }
    
    private func shouldAdjustHeight(in geometry: GeometryProxy) -> Bool {
        return geometry.size.width > geometry.size.height
    }
    
}
